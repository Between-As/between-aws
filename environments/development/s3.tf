module "vpc_flow_log" {
  source                   = "../../modules/s3"
  common_tags              = var.common_tags
  bucket_name              = "between-vpc-flow-logs1"
  s3_default_bucket_policy = false
}

module "s3_loki_storage" {
  source                   = "../../modules/s3"
  common_tags              = var.common_tags
  bucket_name              = "between-loki-storage1"
  s3_default_bucket_policy = false
}