variable "release_name" {
  type = string
}

variable "namespace" {
  type = string
}

variable "repository" {
  type = string
}

variable "chart_name" {
  type = string
}

variable "chart_version" {
  type = string
}

variable "isAtomic" {
  type    = bool
  default = true
}

variable "iam_service_role" {
  type = string
}

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

variable "s3_bucket" {
  type        = string
  description = "S3 bucket for chunks"
}

variable "read_replicas" {
  type = number
  description = "Number of Loki read replicas pods"
  default = 1
}

variable "write_replicas" {
  type = number
  description = "Number of Loki read replicas pods"
  default = 1
}

variable "loki_log_retention" {
  type        = string
  description = "Loki logs retention in S3"
}
