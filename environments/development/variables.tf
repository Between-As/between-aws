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

variable "vault_dynamodb_name" {
  type        = string
  description = "Name of Vault backend - DynamoDB table"
}

variable "aurora_sandbox_cluster_name" {
  type = string
}

variable "aurora_sandbox_engine_family" {
  type = string
}

variable "aurora_sandbox_engine_version" {
  type    = string
  default = "aurora-postgresql"
}

variable "aurora_sandbox_parameter_group_family" {
  type = string
}

variable "aurora_sandbox_postgres_port" {
  type = string
}

variable "aurora_sandbox_postgres_instances" {
  type = number
}

variable "aurora_sandbox_postgres_master_username" {
  type = string
}

variable "aurora_sandbox_postgres_skip_final_snapshot" {
  type = bool
}

variable "aurora_sandbox_postgres_backup_retention_period" {
  type = number
}

variable "aurora_sandbox_postgres_preferred_backup_window" {
  type = string
}

variable "aurora_sandbox_postgres_preferred_maintenance_window" {
  type = string
}

variable "aurora_sandbox_postgres_cloudwatch_logs_exports" {
  type = list(any)
}

variable "aurora_sandbox_postgres_storage_encrypted" {
  type = string
}

variable "aurora_sandbox_postgres_deletion_protection" {
  type = string
}

variable "aurora_sandbox_postgres_apply_immediately" {
  type = string
}

variable "aurora_sandbox_postgres_instance_class" {
  type = string
}

variable "aurora_sandbox_postgres_publicly_accessible" {
  type = bool
}

variable "aurora_sandbox_postgres_performance_insights_enabled" {
  type = bool
}

variable "aurora_staging_cluster_name" {
  type = string
}

variable "aurora_staging_engine_family" {
  type = string
}

variable "aurora_staging_engine_version" {
  type    = string
  default = "aurora-postgresql"
}

variable "aurora_staging_parameter_group_family" {
  type = string
}

variable "aurora_staging_postgres_port" {
  type = string
}

variable "aurora_staging_postgres_instances" {
  type = number
}

variable "aurora_staging_postgres_master_username" {
  type = string
}

variable "aurora_staging_postgres_skip_final_snapshot" {
  type = bool
}

variable "aurora_staging_postgres_backup_retention_period" {
  type = number
}

variable "aurora_staging_postgres_preferred_backup_window" {
  type = string
}

variable "aurora_staging_postgres_preferred_maintenance_window" {
  type = string
}

variable "aurora_staging_postgres_cloudwatch_logs_exports" {
  type = list(any)
}

variable "aurora_staging_postgres_storage_encrypted" {
  type = string
}

variable "aurora_staging_postgres_deletion_protection" {
  type = string
}

variable "aurora_staging_postgres_apply_immediately" {
  type = string
}

variable "aurora_staging_postgres_instance_class" {
  type = string
}

variable "aurora_staging_postgres_publicly_accessible" {
  type = bool
}

variable "aurora_staging_postgres_performance_insights_enabled" {
  type = bool
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
