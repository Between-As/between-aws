data "aws_iam_policy_document" "operator_assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = var.operator_principals
    }
  }
}

data "aws_iam_policy_document" "operator_update_kubeconfig" {
  statement {
    effect    = "Allow"
    actions   = ["eks:DescribeCluster"]
    resources = ["*"]
  }
}

resource "aws_iam_role" "operator_role" {
  name               = "${var.cluster_name}-${local.tag_environment}-operator-role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.operator_assume_role_policy.json
  inline_policy {
    name   = "update-kubeconfig-permission"
    policy = data.aws_iam_policy_document.operator_update_kubeconfig.json
  }
}
