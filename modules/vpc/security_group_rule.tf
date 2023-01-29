locals {
  security_group_rules_cidr = flatten([
    for sg_key, sg_rules in var.security_groups : [
      for rule_key, rule in sg_rules : {
        sg_name     = sg_key
        description = rule_key
        from_port   = rule["from_port"]
        to_port     = rule["to_port"]
        protocol    = rule["protocol"]
        source      = rule["source"]
      } if length(regexall("(\\d+\\.)+\\d+/+\\d+", rule["source"])) > 0
    ]
  ])
  security_group_rules_sg = flatten([
    for sg_key, sg_rules in var.security_groups : [
      for rule_key, rule in sg_rules : {
        sg_name     = sg_key
        description = rule_key
        from_port   = rule["from_port"]
        to_port     = rule["to_port"]
        protocol    = rule["protocol"]
        source      = rule["source"]

      } if rule["source"] != "self" && rule["source"] != "vpc" && length(regexall("^[a-zA-Z0-9_-]+$", rule["source"])) > 0
    ]
  ])
  security_group_rules_self = flatten([
    for sg_key, sg_rules in var.security_groups : [
      for rule_key, rule in sg_rules : {
        sg_name     = sg_key
        description = rule_key
        from_port   = rule["from_port"]
        to_port     = rule["to_port"]
        protocol    = rule["protocol"]
        source      = rule["source"]

      } if rule["source"] == "self"
    ]
  ])
  security_group_rules_vpc = flatten([
    for sg_key, sg_rules in var.security_groups : [
      for rule_key, rule in sg_rules : {
        sg_name     = sg_key
        description = rule_key
        from_port   = rule["from_port"]
        to_port     = rule["to_port"]
        protocol    = rule["protocol"]
        source      = rule["source"]

      } if rule["source"] == "vpc"
    ]
  ])

  security_group_rules_cidr_map = { for sg_rule in local.security_group_rules_cidr : "${sg_rule.sg_name}.${sg_rule.description}" => sg_rule }
  security_group_rules_sg_map   = { for sg_rule in local.security_group_rules_sg : "${sg_rule.sg_name}.${sg_rule.description}" => sg_rule }
  security_group_rules_self_map = { for sg_rule in local.security_group_rules_self : "${sg_rule.sg_name}.${sg_rule.description}" => sg_rule }
  security_group_rules_vpc_map  = { for sg_rule in local.security_group_rules_vpc : "${sg_rule.sg_name}.${sg_rule.description}" => sg_rule }
}

resource "aws_security_group_rule" "egress_default" {
  for_each = var.security_groups

  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "all"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.main[each.key].id
}

resource "aws_security_group_rule" "ingress_cidr" {
  for_each = local.security_group_rules_cidr_map

  security_group_id = aws_security_group.main[each.value["sg_name"]].id
  description       = each.value["description"]
  type              = "ingress"

  from_port = each.value["from_port"]
  to_port   = each.value["to_port"]
  protocol  = each.value["protocol"]

  cidr_blocks = [each.value["source"]]
}

resource "aws_security_group_rule" "ingress_sg" {
  for_each = local.security_group_rules_sg_map

  security_group_id = aws_security_group.main[each.value["sg_name"]].id
  description       = each.value["description"]
  type              = "ingress"

  from_port = each.value["from_port"]
  to_port   = each.value["to_port"]
  protocol  = each.value["protocol"]

  source_security_group_id = aws_security_group.main[each.value["source"]].id
}

resource "aws_security_group_rule" "ingress_self" {
  for_each = local.security_group_rules_self_map

  security_group_id = aws_security_group.main[each.value["sg_name"]].id
  description       = each.value["description"]
  type              = "ingress"

  from_port = each.value["from_port"]
  to_port   = each.value["to_port"]
  protocol  = each.value["protocol"]

  self = true
}

resource "aws_security_group_rule" "ingress_vpc" {
  for_each = local.security_group_rules_vpc_map

  security_group_id = aws_security_group.main[each.value["sg_name"]].id
  description       = each.value["description"]
  type              = "ingress"

  from_port = each.value["from_port"]
  to_port   = each.value["to_port"]
  protocol  = each.value["protocol"]

  cidr_blocks = [aws_vpc.main.cidr_block]
}