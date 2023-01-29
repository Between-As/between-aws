locals {
  tag_environment = lookup(var.common_tags, "environment", "")
  subnet_arns_list = formatlist("arn:aws:ec2:${var.aws_region}:${data.aws_caller_identity.current.account_id}:subnet/%s", var.subnet_list)
}