aws = {
  allowed_account_id = "162725507128"
  profile            = "between_development"
  region             = "eu-west-1"
}

common_tags = {
  environment = "development"
  maintainer  = "Edward"
  iac         = "true"
  managed     = "terraform"
}

eks_cluster_name = "between-eks"

eks_operator_principals = [
  "arn:aws:iam::162725507128:root",
]

eks_readonly_principals = [
  "arn:aws:iam::162725507128:root",
]

eks_public_access_cidrs = [
  "51.174.116.13/32",
  "0.0.0.0/0"
]

# Grafana Loki
loki_log_retention = "336h"

external_dns_utilities_role_arn  = "arn:aws:iam::311685012708:role/utilities-external-dns-role-development"

security_groups = {
  "vpc-endpoint" = {
    "internal" = { from_port = 443, to_port = 443, protocol = "tcp", source = "10.10.0.0/16" }
  }

  "eks-cluster" = {
    "internal" = { from_port = 0, to_port = 0, protocol = "all", source = "10.10.0.0/16" }
  }

  "alb" = {
    "HTTP"  = { from_port = 80, to_port = 80, protocol = "tcp", source = "0.0.0.0/0" }
    "HTTPS" = { from_port = 443, to_port = 443, protocol = "tcp", source = "0.0.0.0/0" }
  }
}

# Aurora Postgres sandbox
aurora_sandbox_cluster_name                         = "sandbox"
aurora_sandbox_engine_family                         = "aurora-postgresql"
aurora_sandbox_engine_version                        = "14.3"
aurora_sandbox_parameter_group_family                = "aurora-postgresql14"
aurora_sandbox_postgres_port                         = "5432"
aurora_sandbox_postgres_master_username              = "master"
aurora_sandbox_postgres_skip_final_snapshot          = true
aurora_sandbox_postgres_backup_retention_period      = 7
aurora_sandbox_postgres_preferred_backup_window      = "01:00-02:00"
aurora_sandbox_postgres_preferred_maintenance_window = "sun:02:00-sun:03:00"
aurora_sandbox_postgres_cloudwatch_logs_exports      = ["postgresql"]
aurora_sandbox_postgres_storage_encrypted            = true
aurora_sandbox_postgres_deletion_protection          = false
aurora_sandbox_postgres_apply_immediately            = true
aurora_sandbox_postgres_instances                    = 2
aurora_sandbox_postgres_instance_class               = "db.t3.medium"
aurora_sandbox_postgres_publicly_accessible          = true
aurora_sandbox_postgres_performance_insights_enabled = false

# Aurora Postgres sandbox
aurora_staging_cluster_name                         = "staging"
aurora_staging_engine_family                         = "aurora-postgresql"
aurora_staging_engine_version                        = "14.3"
aurora_staging_parameter_group_family                = "aurora-postgresql14"
aurora_staging_postgres_port                         = "5432"
aurora_staging_postgres_master_username              = "master"
aurora_staging_postgres_skip_final_snapshot          = true
aurora_staging_postgres_backup_retention_period      = 7
aurora_staging_postgres_preferred_backup_window      = "01:00-02:00"
aurora_staging_postgres_preferred_maintenance_window = "sun:02:00-sun:03:00"
aurora_staging_postgres_cloudwatch_logs_exports      = ["postgresql"]
aurora_staging_postgres_storage_encrypted            = true
aurora_staging_postgres_deletion_protection          = false
aurora_staging_postgres_apply_immediately            = true
aurora_staging_postgres_instances                    = 2
aurora_staging_postgres_instance_class               = "db.t3.medium"
aurora_staging_postgres_publicly_accessible          = true
aurora_staging_postgres_performance_insights_enabled = false

vault_dynamodb_name           = "vault-backend"

admin_password             = "5kTY6mVJrPmbm4RjBUKX4e" # temporary password
grafana_certificate        = "arn:aws:acm:eu-west-1:162725507128:certificate/06257c67-8f70-4291-affb-a70c57433ce3"
grafana_group_name         = "apps-development"
grafana_subnets            = "subnet-0d91e3c4e0876a717,subnet-04ff721edeb55c7d0,subnet-0bc73c4431939529b"
grafana_domain             = "development-grafana.between.as"
prometheus_certificate     = "arn:aws:acm:eu-west-1:162725507128:certificate/06257c67-8f70-4291-affb-a70c57433ce3"
prometheus_group_name      = "apps-development"
prometheus_subnets         = "subnet-0d91e3c4e0876a717,subnet-04ff721edeb55c7d0,subnet-0bc73c4431939529b"
prometheus_domain          = "development-prometheus.between.as"
