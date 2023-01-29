variable "common_tags" {
  type        = map(string)
  description = "tags configurations"
}

variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
}

variable "cluster_role_arn" {
  type        = string
  description = "EKS cluster role ARN"
}

variable "cluster_version" {
  type        = string
  description = "EKS cluster version"
}

variable "cluster_subnet_ids" {
  type        = list(any)
  description = "List of subnets to EKS cluster to operate"
}

variable "cloudwatch_logs_retention" {
  type        = number
  default     = 7
  description = "EKS cluster logs retention"
}

variable "security_group_ids" {
  type        = list(any)
  default     = []
  description = "EKS cluster additional security groups if any"
}

variable "public_access_cidrs" {
  type        = list(any)
  default     = []
  description = "Subnets with EKS public API access"
}


# variable "operator_role_arn" {
#   type    = string
#   default = ""
# }

# variable "worker_role_arn" {
#   type = string
# }

variable "cluster_log_types" {
  type    = list(any)
  default = [] # ["api", "audit"]
}
