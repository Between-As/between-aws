resource "aws_dynamodb_table" "vault_table" {
  name           = "${var.dynamodb_table_name}-${local.tag_environment}"
  #read_capacity  = var.read_capacity
  #write_capacity = var.write_capacity
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "Path"
  range_key      = "Key"

  attribute {
    name = "Path"
    type = "S"
  }

  attribute {
    name = "Key"
    type = "S"
  }

  tags = merge(
    tomap({ "Name" = format("%s-%s", var.dynamodb_table_name, local.tag_environment) }),
    var.common_tags
  )
}