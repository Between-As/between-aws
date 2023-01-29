data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "default_kms_policy" {
  statement {
    actions = [
      "kms:*"
    ]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }

    resources = [
      "*"
    ]

    effect = "Allow"
  }
}

data "aws_iam_policy_document" "autoscaling_kms_policy" {
  statement {
    actions = [
      "kms:*"
    ]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }

    resources = [
      "*"
    ]

    effect = "Allow"
  }

  statement {
    actions = [
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:Encrypt",
      "kms:DescribeKey",
      "kms:Decrypt",
    ]

    principals {
      type        = "AWS"
      identifiers = ["${aws_iam_service_linked_role.autoscaling.id}"]
    }

    resources = [
      "*"
    ]

    effect = "Allow"
  }

  statement {
    actions = [
      "kms:CreateGrant",
    ]
    principals {
      type        = "AWS"
      identifiers = ["${aws_iam_service_linked_role.autoscaling.id}"]
    }

    resources = [
      "*"
    ]

    effect = "Allow"
  }
}

# AWSServiceRoleForAutoScaling
resource "aws_iam_service_linked_role" "autoscaling" {
  aws_service_name = "autoscaling.amazonaws.com"
}

resource "aws_kms_key" "key" {
  description             = var.description
  deletion_window_in_days = var.deletion_days
  enable_key_rotation     = var.enable_key_rotation
  tags                    = var.common_tags
  policy                  = var.add_autoscaling_permissions == true ? data.aws_iam_policy_document.autoscaling_kms_policy.json : data.aws_iam_policy_document.default_kms_policy.json
}

resource "aws_kms_alias" "alias" {
  name          = "alias/${local.tag_environment}-${var.alias}"
  target_key_id = aws_kms_key.key.key_id
}
