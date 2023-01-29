resource "aws_eks_cluster" "eks" {
  name     = "${var.cluster_name}-${local.tag_environment}"
  role_arn = var.cluster_role_arn
  version  = var.cluster_version

  vpc_config {
    subnet_ids              = var.cluster_subnet_ids
    endpoint_private_access = true
    endpoint_public_access  = true
    security_group_ids      = var.security_group_ids
    public_access_cidrs     = var.public_access_cidrs
  }

  depends_on = [aws_cloudwatch_log_group.eks]

  enabled_cluster_log_types = var.cluster_log_types

}

data "aws_eks_cluster_auth" "eks" {
  name = aws_eks_cluster.eks.name
}
