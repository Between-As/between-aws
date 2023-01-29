data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "loki_assume_policy_document" {
  statement {
    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]

    resources = [
      "*"
    ]

    effect = "Allow"
  }
}

data "aws_iam_policy_document" "loki_s3_policy_document" {
  statement {
    actions = [
      "s3:ListObjects",
      "s3:ListBucket",
      "s3:PutObject",
      "s3:GetObject",
      "s3:DeleteObject"
    ]

    resources = [
      "${var.s3_bucket_arn}",
      "${var.s3_bucket_arn}/*"
    ]

    effect = "Allow"
  }
}


resource "aws_iam_policy" "loki_assume_policy" {
  name        = "${var.cluster_name}-${local.tag_environment}-loki-assume-role"
  description = "Loki assume policy"
  policy      = data.aws_iam_policy_document.loki_assume_policy_document.json

  tags = var.common_tags
}

resource "aws_iam_policy" "loki_s3_policy" {
  name        = "${var.cluster_name}-${local.tag_environment}-loki-s3"
  description = "Loki S3 backend policy"
  policy      = data.aws_iam_policy_document.loki_s3_policy_document.json

  tags = var.common_tags
}

resource "aws_iam_role_policy_attachment" "loki_service_role_assume_policy_attachment" {
  role       = var.service_role
  policy_arn = aws_iam_policy.loki_assume_policy.arn
}

resource "aws_iam_role_policy_attachment" "loki_service_role_s3_policy_attachment" {
  role       = var.service_role
  policy_arn = aws_iam_policy.loki_s3_policy.arn
}
