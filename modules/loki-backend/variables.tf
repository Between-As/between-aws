variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
}

variable "aws_region" {
  type = string
}

variable "common_tags" {
  type        = map(string)
  description = "tags configurations"
}

variable "service_role" {
  type        = string
  description = "ServiceAccount role arn"
}

variable "s3_bucket_arn" {
  type        = string
  description = "S3 bucket for chunks"
}
