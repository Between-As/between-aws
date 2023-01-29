resource "aws_iam_openid_connect_provider" "eks_production" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [var.oidc_eks_thumbprint_production]
  url             = var.oidc_eks_url_production
  tags            = var.common_tags
}

resource "aws_iam_openid_connect_provider" "eks_staging" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [var.oidc_eks_thumbprint_staging]
  url             = var.oidc_eks_url_staging
  tags            = var.common_tags
}

resource "aws_iam_openid_connect_provider" "eks_sandbox" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [var.oidc_eks_thumbprint_sandbox]
  url             = var.oidc_eks_url_sandbox
  tags            = var.common_tags
}