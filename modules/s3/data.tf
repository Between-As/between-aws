data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "s3_bucket_policy" {
  statement {
    sid    = "DisableHTTP"
    effect = "Deny"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = [
      "${aws_s3_bucket.main.arn}/*"
    ]

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values   = [false]
    }
  }
}