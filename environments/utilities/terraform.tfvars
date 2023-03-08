aws = {
  allowed_account_id = "581141568906"
  profile            = "izy-as-utilities"
  region             = "eu-north-1"
  region_non_prod    = "eu-west-1"
}

common_tags = {
  environment = "utilities"
  maintainer  = "Edward"
  iac         = "true"
  managed     = "terraform"
}

# Route53
route53_domains = {
  "izy.no" = {
    domain_name   = "between.as"
    force_destroy = true
    is_internal   = false
  }
}

between_as_domain_id               = "Z005741429QSQ2PFVZLW8"

# IAM Identity Providers are created on utilities account for cross-account access
oidc_eks_url_production        = "https://oidc.eks.eu-north-1.amazonaws.com/id/0396D5ECF1620EE123147C1CB6A72266"
oidc_eks_arn_production        = "arn:aws:iam::581141568906:oidc-provider/oidc.eks.eu-north-1.amazonaws.com/id/0396D5ECF1620EE123147C1CB6A72266"
oidc_eks_thumbprint_production = "9e99a48a9960b14926bb7f3b02e22da2b0ab7280"

oidc_eks_url_staging           = "https://oidc.eks.eu-west-1.amazonaws.com/id/F6372565F1B0774BFCA5B856A637D653"
oidc_eks_arn_staging           = "arn:aws:iam::581141568906:oidc-provider/oidc.eks.eu-west-1.amazonaws.com/id/F6372565F1B0774BFCA5B856A637D653"
oidc_eks_thumbprint_staging    = "9e99a48a9960b14926bb7f3b02e22da2b0ab7280"

oidc_eks_url_sandbox           = "https://oidc.eks.eu-west-1.amazonaws.com/id/125062311CF9EE9C9967866910B13AB7"
oidc_eks_arn_sandbox           = "arn:aws:iam::581141568906:oidc-provider/oidc.eks.eu-west-1.amazonaws.com/id/125062311CF9EE9C9967866910B13AB7"
oidc_eks_thumbprint_sandbox    = "9e99a48a9960b14926bb7f3b02e22da2b0ab7280"