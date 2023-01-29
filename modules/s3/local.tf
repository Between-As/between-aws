locals {
  tag_environment = lookup(var.common_tags, "environment", "")
}
