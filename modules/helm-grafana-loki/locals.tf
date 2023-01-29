locals {
  tag_environment = lookup(var.common_tags, "environment", "")
  index_prefix    = "${local.tag_environment}_loki_index_"
}