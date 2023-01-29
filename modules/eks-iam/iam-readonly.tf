data "aws_iam_policy_document" "readonly_assume_role_policy" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "AWS"
      identifiers = var.readonly_principals
    }
  }
}

data "aws_iam_policy_document" "readonly_update_kubeconfig" {
  statement {
    effect    = "Allow"
    actions   = ["eks:DescribeCluster"]
    resources = ["*"]
  }
}

resource "aws_iam_role" "readonly_role" {
  name               = "${var.cluster_name}-${local.tag_environment}-readonly-role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.readonly_assume_role_policy.json
  inline_policy {
    name   = "update-kubeconfig-permission"
    policy = data.aws_iam_policy_document.readonly_update_kubeconfig.json
  }
}
