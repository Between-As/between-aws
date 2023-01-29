variable "aws" {
  type        = map(any)
  description = "AWS credentials for terraform"
}

variable "common_tags" {
  type        = map(string)
  description = "tags configurations"
}

variable "internal_domain" {
  type        = string
  description = "Name of internal domain"
}

variable "route53_domains" {
  type        = map(any)
  description = "Zones configuration"
}

variable "external_dns_utilities_role_arn" {
  type        = string
  description = "ARN of the role on Utilities account for External-DNS service"
}

variable "security_groups" {
  type        = map(any)
  description = "Security group map"
}

variable "eks_cluster_name" {
  type        = string
  description = "EKS cluster name"
}

variable "eks_nodes_asg_min_capacity" {
  type        = number
  description = "EKS nodes minimum capacity"
}

variable "eks_nodes_asg_max_capacity" {
  type        = number
  description = "EKS nodes maximum capacity"
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

variable "vault_dynamodb_name" {
  type        = string
  description = "Name of Vault backend - DynamoDB table"
}

/*variable "vault_dynamodb_read_capacity" {
  type        = number
  description = "Name of Vault backend - DynamoDB read units"
}

variable "vault_dynamodb_write_capacity" {
  type        = number
  description = "Name of Vault backend - DynamoDB write units"
}*/

variable "aurora_engine_family" {
  type = string
}

variable "aurora_engine_version" {
  type    = string
  default = "aurora-postgresql"
}

variable "aurora_parameter_group_family" {
  type = string
}

variable "aurora_postgres_port" {
  type = string
}

variable "aurora_postgres_instances" {
  type = number
}

variable "aurora_postgres_master_username" {
  type = string
}

variable "aurora_postgres_skip_final_snapshot" {
  type = bool
}

variable "aurora_postgres_backup_retention_period" {
  type = number
}

variable "aurora_postgres_preferred_backup_window" {
  type = string
}

variable "aurora_postgres_preferred_maintenance_window" {
  type = string
}

variable "aurora_postgres_cloudwatch_logs_exports" {
  type = list(any)
}

variable "aurora_postgres_storage_encrypted" {
  type = string
}

variable "aurora_postgres_deletion_protection" {
  type = string
}

variable "aurora_postgres_apply_immediately" {
  type = string
}

variable "aurora_postgres_instance_class" {
  type = string
}

variable "aurora_postgres_publicly_accessible" {
  type = bool
}

variable "aurora_postgres_performance_insights_enabled" {
  type = bool
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
