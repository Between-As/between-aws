module "vpc_flow_log" {
  source                   = "../../modules/s3"
  common_tags              = var.common_tags
  bucket_name              = "izy30-vpc-flow-logs"
  s3_default_bucket_policy = false
}

module "s3_loki_storage" {
  source                   = "../../modules/s3"
  common_tags              = var.common_tags
  bucket_name              = "izy30-loki-storage"
  s3_default_bucket_policy = false
}