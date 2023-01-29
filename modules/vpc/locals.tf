locals {
  availability_zones = slice(data.aws_availability_zones.availability_zones.names, 0, var.availability_zones)
  tag_environment    = lookup(var.common_tags, "environment", "")
}