variable "common_tags" {
  type = map(any)
}
variable "name" {
  type = string
}
variable "vpc_id" {
  type = string
}

variable "aurora_subnets_list" {
  type = list(any)
}

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

variable "aurora_postgres_master_password_seed" {
  type = string
}

variable "eks_cluster_security_group_id" {
  type = string
}

variable "codebuild_security_group_id" {
  type = string
}

variable "rds_access_security_group_id" {
  type = string
}