data "aws_iam_policy" "AmazonEKSClusterPolicy" {
  arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# https://docs.aws.amazon.com/eks/latest/userguide/service_IAM_role.html
# no need more AmazonEKSServicePolicy

data "aws_iam_policy" "AmazonEKSVPCResourceController" {
  arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
}

data "aws_iam_policy_document" "eks_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }

    effect = "Allow"
  }
}

data "aws_iam_policy_document" "eks_cw_logs_policy" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogStreams"
    ]

    resources = [
      "arn:aws:logs:*:*:*"
    ]

    effect = "Allow"
  }
}

data "aws_iam_policy_document" "eks_cluster_kms_permissions" {
  statement {
    actions = [
      "kms:*"
    ]

    resources = [
      var.node_kms_key_arn
    ]

    effect = "Allow"
  }
}


resource "aws_iam_policy" "eks_cluster_kms_permissions" {
  name        = "${var.cluster_name}-${local.tag_environment}-kms-volumes"
  description = "KMS for EKS volumes policy"
  policy      = data.aws_iam_policy_document.eks_cluster_kms_permissions.json
}

resource "aws_iam_policy" "cw_logs_writer" {
  name        = "${var.cluster_name}-${local.tag_environment}-cwlogs-writer"
  description = "CW Logs Writing Policy"
  policy      = data.aws_iam_policy_document.eks_cw_logs_policy.json
}

resource "aws_iam_role" "eks_role" {
  name               = "${var.cluster_name}-${local.tag_environment}-role"
  assume_role_policy = data.aws_iam_policy_document.eks_assume_role_policy.json
}

resource "aws_iam_role_policy_attachment" "eks_role_cluster_policy" {
  role       = aws_iam_role.eks_role.name
  policy_arn = data.aws_iam_policy.AmazonEKSClusterPolicy.arn
}

resource "aws_iam_role_policy_attachment" "eks_vpc_controller_service_policy" {
  role       = aws_iam_role.eks_role.name
  policy_arn = data.aws_iam_policy.AmazonEKSVPCResourceController.arn
}

resource "aws_iam_role_policy_attachment" "eks_role_cw_logs_policy" {
  role       = aws_iam_role.eks_role.name
  policy_arn = aws_iam_policy.cw_logs_writer.arn
}

resource "aws_iam_role_policy_attachment" "eks_cluster_kms_permissions" {
  role       = aws_iam_role.eks_role.name
  policy_arn = aws_iam_policy.eks_cluster_kms_permissions.arn
}
