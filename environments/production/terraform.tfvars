# AWS account
aws = {
  allowed_account_id = "169207823547"
  profile            = "izy30-prod"
  region             = "eu-north-1"
}


# Tags
common_tags = {
  environment = "production"
  maintainer  = "hostersi"
  iac         = "true"
  managed     = "terraform"
}


# Aurora Postgres
aurora_engine_family                         = "aurora-postgresql"
aurora_engine_version                        = "14.3"
aurora_parameter_group_family                = "aurora-postgresql14"
aurora_postgres_port                         = "5432"
aurora_postgres_master_username              = "master"
aurora_postgres_skip_final_snapshot          = true
aurora_postgres_backup_retention_period      = 7
aurora_postgres_preferred_backup_window      = "01:00-02:00"
aurora_postgres_preferred_maintenance_window = "sun:02:00-sun:03:00"
aurora_postgres_cloudwatch_logs_exports      = ["postgresql"]
aurora_postgres_storage_encrypted            = true
aurora_postgres_deletion_protection          = false
aurora_postgres_apply_immediately            = true
aurora_postgres_instances                    = 2
aurora_postgres_instance_class               = "db.t3.medium"
aurora_postgres_publicly_accessible          = false
aurora_postgres_performance_insights_enabled = false


# Route53
internal_domain = "izy-production.local"

route53_domains = {
  "izy-production.local" = {
    domain_name   = "izy-production.local"
    force_destroy = true
    is_internal   = true
  }
}

external_dns_utilities_role_arn  = "arn:aws:iam::581141568906:role/utilities-external-dns-role-production"


# EKS
eks_cluster_name = "izy30-eks"
eks_nodes_asg_min_capacity = 2
eks_nodes_asg_max_capacity = 16

eks_operator_principals = [
  "arn:aws:iam::317927401331:root",
]

eks_readonly_principals = [
  "arn:aws:iam::317927401331:root",
]

eks_public_access_cidrs = [
  "91.201.153.118/32",
  "51.174.116.13/32"
]

# Grafana Loki
loki_log_retention = "2232h"

# Security groups
security_groups = {
  "management" = {
    "Hostersi Public" = { from_port = 0, to_port = 0, protocol = "all", source = "91.201.153.118/32" }
  }

  "vpc-endpoint" = {
    "internal" = { from_port = 443, to_port = 443, protocol = "tcp", source = "10.202.64.0/20" }
  }

  "eks-cluster" = {
    "internal" = { from_port = 0, to_port = 0, protocol = "all", source = "10.202.64.0/20" }
  }

  "alb" = {
    "HTTP"  = { from_port = 80, to_port = 80, protocol = "tcp", source = "0.0.0.0/0" }
    "HTTPS" = { from_port = 443, to_port = 443, protocol = "tcp", source = "0.0.0.0/0" }
  }
}


# Hashicorp Vault 
vault_dynamodb_name           = "vault-backend"
#vault_dynamodb_read_capacity  = 10
#vault_dynamodb_write_capacity = 10

admin_password             = "CHFwrbIcjq4zXEvgGAXh" # temporary password
grafana_certificate        = "arn:aws:acm:eu-north-1:169207823547:certificate/d192b4bb-fa01-4996-bb91-dcce94697da0"
grafana_group_name         = "apps-production"
grafana_subnets            = "subnet-0b64e228cf1622ae6,subnet-06486832144ba7942,subnet-04d507ab370216c8b"
grafana_domain             = "production-grafana.izy.no"
prometheus_certificate     = "arn:aws:acm:eu-north-1:169207823547:certificate/d192b4bb-fa01-4996-bb91-dcce94697da0"
prometheus_group_name      = "apps-production"
prometheus_subnets         = "subnet-0b64e228cf1622ae6,subnet-06486832144ba7942,subnet-04d507ab370216c8b"
prometheus_domain          = "production-prometheus.izy.no"
