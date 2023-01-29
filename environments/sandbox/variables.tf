variable "aws" {
  type        = map(any)
  description = "AWS credentials for terraform"
}

variable "common_tags" {
  type        = map(string)
  description = "tags configurations"
}

variable "security_groups" {
  type        = map(any)
  description = "Security group map"
}

variable "eks_cluster_name" {
  type        = string
  description = "EKS cluster name"
}

variable "eks_operator_principals" {
  type        = list(string)
  description = "Entities allowed to assume eks operator role"
}

variable "eks_readonly_principals" {
  type        = list(string)
  description = "Entities allowed to assume eks readonly role"
}

variable "eks_public_access_cidrs" {
  type        = list(any)
  default     = []
  description = "Subnets with EKS public API access"
}

variable "loki_log_retention" {
  type        = string
  description = "Loki logs retention in S3"
}

variable "external_dns_utilities_role_arn" {
  type        = string
  description = "ARN of the role on Utilities account for External-DNS service"
}

variable "admin_password" {
  type = string
  description = "Temporary admin password"
}

variable "grafana_certificate" {
  type = string
  description = "ARN to certificate"
}

variable "grafana_group_name" {
  type = string
  description = "AWS Load Balancer Controller group name"
}

variable "grafana_subnets" {
  type = string
  description = "Subnets"
}

variable "grafana_domain" {
  type = string
  description = "Service domain"
}

variable "prometheus_certificate" {
  type = string
  description = "ARN to certificate"
}

variable "prometheus_group_name" {
  type = string
  description = "AWS Load Balancer Controller group name"
}

variable "prometheus_subnets" {
  type = string
  description = "Subnets"
}

variable "prometheus_domain" {
  type = string
  description = "Service domain"
}
