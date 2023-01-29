resource "aws_cloudwatch_log_group" "eks" {
  name              = "/aws/eks/${local.tag_environment}/${var.cluster_name}/cluster"
  retention_in_days = var.cloudwatch_logs_retention

  tags = merge(
    tomap(
      { "Name" = "/aws/eks/${local.tag_environment}/${var.cluster_name}/cluster" },
    ),
  var.common_tags)
}

resource "aws_cloudwatch_log_group" "eks_workers" {
  name              = "/aws/eks/${local.tag_environment}/${var.cluster_name}/instances"
  retention_in_days = var.cloudwatch_logs_retention

  tags = merge(
    tomap(
      { "Name" = "/aws/eks/${local.tag_environment}/${var.cluster_name}/instances" },
    ),
  var.common_tags)
}
