aws = {
  allowed_account_id = "759976795385"
  profile            = "izy30-dev"
  region             = "eu-west-1"
}

common_tags = {
  environment = "sandbox"
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
  "91.201.153.118/32",
  "51.174.116.13/32",
  "0.0.0.0/0"
]

# Grafana Loki
loki_log_retention = "336h"

external_dns_utilities_role_arn  = "arn:aws:iam::581141568906:role/utilities-external-dns-role-sandbox"

security_groups = {
  "management" = {
    "Hostersi Public" = { from_port = 0, to_port = 0, protocol = "all", source = "91.201.153.118/32" }
  }

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

admin_password             = "5kTY6mVJrPmbm4RjBUKX4e" # temporary password
grafana_certificate        = "arn:aws:acm:eu-west-1:759976795385:certificate/06257c67-8f70-4291-affb-a70c57433ce3"
grafana_group_name         = "apps-sandbox"
grafana_subnets            = "subnet-0d91e3c4e0876a717,subnet-04ff721edeb55c7d0,subnet-0bc73c4431939529b"
grafana_domain             = "sandbox-grafana.izy.no"
prometheus_certificate     = "arn:aws:acm:eu-west-1:759976795385:certificate/06257c67-8f70-4291-affb-a70c57433ce3"
prometheus_group_name      = "apps-sandbox"
prometheus_subnets         = "subnet-0d91e3c4e0876a717,subnet-04ff721edeb55c7d0,subnet-0bc73c4431939529b"
prometheus_domain          = "sandbox-prometheus.izy.no"
