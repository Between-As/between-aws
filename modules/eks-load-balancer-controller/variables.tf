variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
}

variable "iam_service_role" {
  type        = string
  description = "ServiceAccount role arn"
}

variable "common_tags" {
  type        = map(string)
  description = "tags configurations"
}
