variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
}

variable "common_tags" {
  type        = map(string)
  description = "tags configurations"
}

variable "grafana_service_role" {
  type        = string
  description = "ServiceAccount role arn"
}