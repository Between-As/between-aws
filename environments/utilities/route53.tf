module "route53_zone" {
  source      = "../../modules/route53-zone"
  common_tags = var.common_tags
  
  for_each = var.route53_domains

  domain_name    = each.value["domain_name"]
  force_destroy  = each.value["force_destroy"]
  is_internal    = each.value["is_internal"]
}

module "iam_external_dns_production" {
  source      = "../../modules/iam-external-dns"
  common_tags = var.common_tags

  domain_zone_id       = var.izy_no_domain_id
  oidc_eks_arn         = aws_iam_openid_connect_provider.eks_production.arn
  oidc_eks_url         = var.oidc_eks_url_production
  eks_environment_name = "production"
 
  depends_on = [module.route53_zone]
}

module "iam_external_dns_staging" {
  source      = "../../modules/iam-external-dns"
  common_tags = var.common_tags

  domain_zone_id       = var.izy_no_domain_id
  oidc_eks_arn         = aws_iam_openid_connect_provider.eks_staging.arn
  oidc_eks_url         = var.oidc_eks_url_staging
  eks_environment_name = "staging"
 
  depends_on = [module.route53_zone]
}

module "iam_external_dns_sandbox" {
  source      = "../../modules/iam-external-dns"
  common_tags = var.common_tags

  domain_zone_id       = var.izy_no_domain_id
  oidc_eks_arn         = aws_iam_openid_connect_provider.eks_sandbox.arn
  oidc_eks_url         = var.oidc_eks_url_sandbox
  eks_environment_name = "sandbox"
 
  depends_on = [module.route53_zone]
}
