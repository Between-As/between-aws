resource "aws_ssm_parameter" "parameter_map" {
  for_each = {  for obj in local.parameter_store_keys : "${obj.microservice_name}-${obj.parameter}" => obj.parameter  }

  name     = "/${var.prefix}/${local.tag_environment}/${split("-",each.key)[0]}/${each.value}"
  type     = "SecureString"
  value    = "CHANGE_ME"
  tags     = var.common_tags

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}





