resource "aws_security_group" "main" {
  for_each = var.security_groups

  name        = format("%s-%s", lower(local.tag_environment), each.key)
  description = format("%s-%s", lower(local.tag_environment), each.key)
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = format("%s-%s", lower(local.tag_environment), each.key)
  }
}

resource "aws_security_group" "codebuild_sg" {
  name   = "${local.tag_environment}-codebuild-sg"
  vpc_id = aws_vpc.main.id

  tags = {
    Name = format("%s-%s", lower(local.tag_environment), "codebuild-access-sg")
  }
}

resource "aws_security_group_rule" "codebuild_allow_self" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  security_group_id = "${aws_security_group.codebuild_sg.id}"
  source_security_group_id = "${aws_security_group.codebuild_sg.id}" 
}

resource "aws_security_group_rule" "codebuild_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.codebuild_sg.id}"
}

resource "aws_security_group" "rds_access_sg" {
  name   = "${local.tag_environment}-rds-access-sg"
  vpc_id = aws_vpc.main.id

  tags = {
    Name = format("%s-%s", lower(local.tag_environment), "rds-access-sg")
  }
}

resource "aws_security_group_rule" "rds_access_allow_self" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  security_group_id = "${aws_security_group.rds_access_sg.id}"
  source_security_group_id = "${aws_security_group.rds_access_sg.id}" 
}

resource "aws_security_group_rule" "rds_access_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.rds_access_sg.id}"
}

/*resource "aws_security_group" "vault_access_sg" {
  name   = "${local.tag_environment}-vault-access-sg"
  vpc_id = aws_vpc.main.id

  tags = {
    Name = format("%s-%s", lower(local.tag_environment), "vault-access-sg")
  }
}

resource "aws_security_group_rule" "vault_access_allow" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.vault_access_sg.id}" 
}

resource "aws_security_group_rule" "vault_access_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.vault_access_sg.id}"
}*/