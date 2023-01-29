aws = {
  allowed_account_id = "759976795385"
  profile            = "izy30-dev"
  region             = "eu-west-1"
}

common_tags = {
  environment = "staging"
  maintainer  = "hostersi"
  iac         = "true"
  managed     = "terraform"
}

eks_cluster_name = "izy30-eks"

eks_operator_principals = [
  "arn:aws:iam::317927401331:root",
]

eks_readonly_principals = [
  "arn:aws:iam::317927401331:root",
]

eks_public_access_cidrs = [
  "0.0.0.0/0",
  "91.201.153.118/32",
  "51.174.116.13/32"
]

# Grafana Loki
loki_log_retention = "336h"

external_dns_utilities_role_arn  = "arn:aws:iam::581141568906:role/utilities-external-dns-role-staging"

security_groups = {
  "management" = {
    "Hostersi Public" = { from_port = 0, to_port = 0, protocol = "all", source = "91.201.153.118/32" }
  }

  "vpc-endpoint" = {
    "internal" = { from_port = 443, to_port = 443, protocol = "tcp", source = "10.11.0.0/16" }
  }

  "eks-cluster" = {
    "internal" = { from_port = 0, to_port = 0, protocol = "all", source = "10.11.0.0/16" }
  }

  "alb" = {
    "HTTP"  = { from_port = 80, to_port = 80, protocol = "tcp", source = "0.0.0.0/0" }
    "HTTPS" = { from_port = 443, to_port = 443, protocol = "tcp", source = "0.0.0.0/0" }
  }
}

admin_password             = "dbsm2Nkih8SJjXkia6dGfs" # temporary password
grafana_certificate        = "arn:aws:acm:eu-west-1:759976795385:certificate/06257c67-8f70-4291-affb-a70c57433ce3"
grafana_group_name         = "apps-staging"
grafana_subnets            = "subnet-061f66457c90332fb,subnet-0e5bafdf7729b148a,subnet-033b2107be624e4bc"
grafana_domain             = "staging-grafana.izy.no"
prometheus_certificate     = "arn:aws:acm:eu-west-1:759976795385:certificate/06257c67-8f70-4291-affb-a70c57433ce3"
prometheus_group_name      = "apps-staging"
prometheus_subnets         = "subnet-061f66457c90332fb,subnet-0e5bafdf7729b148a,subnet-033b2107be624e4bc"
prometheus_domain          = "staging-prometheus.izy.no"