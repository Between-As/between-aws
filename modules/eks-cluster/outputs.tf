output "cluster_name" {
  value = aws_eks_cluster.eks.id
}

output "cluster_endpoint" {
  value = aws_eks_cluster.eks.endpoint
}

output "cluster_certificate_authority_data" {
  value = aws_eks_cluster.eks.certificate_authority[0].data
}

output "oidc_eks_arn" {
  value = aws_iam_openid_connect_provider.eks.arn
}

output "oidc_eks_url" {
  value = aws_iam_openid_connect_provider.eks.url
}

output "eks_security_group_id" {
  value = aws_eks_cluster.eks.vpc_config[0].cluster_security_group_id
}
