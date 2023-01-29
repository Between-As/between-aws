data "aws_iam_policy_document" "vault_assume_policy_document" {
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


data "aws_iam_policy_document" "vault_kms_policy_document" {
  statement {
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:DescribeKey"
    ]

    resources = [
      aws_kms_key.vault-key.arn
    ]

    effect = "Allow"
  }
}

data "aws_iam_policy_document" "vault_dynamodb_policy_document" {
  statement {
    actions = [
      "dynamodb:DescribeLimits",
      "dynamodb:DescribeTimeToLive",
      "dynamodb:ListTagsOfResource",
      "dynamodb:DescribeReservedCapacityOfferings",
      "dynamodb:DescribeReservedCapacity",
      "dynamodb:ListTables",
      "dynamodb:BatchGetItem",
      "dynamodb:BatchWriteItem",
      "dynamodb:CreateTable",
      "dynamodb:DeleteItem",
      "dynamodb:GetItem",
      "dynamodb:GetRecords",
      "dynamodb:PutItem",
      "dynamodb:Query",
      "dynamodb:UpdateItem",
      "dynamodb:Scan",
      "dynamodb:DescribeTable"
    ]

    resources = [
      aws_dynamodb_table.vault_table.arn
    ]

    effect = "Allow"
  }
}


resource "aws_iam_policy" "vault_assume_policy" {
  name        = "${var.cluster_name}-${local.tag_environment}-vault-assume-role"
  description = "Vault assume policy"
  policy      = data.aws_iam_policy_document.vault_assume_policy_document.json

  tags = var.common_tags
}

resource "aws_iam_policy" "vault_kms_policy" {
  name        = "${var.cluster_name}-${local.tag_environment}-vault-kms"
  description = "Vault KMS policy"
  policy      = data.aws_iam_policy_document.vault_kms_policy_document.json

  tags = var.common_tags
}

resource "aws_iam_policy" "vault_dynamodb_policy" {
  name        = "${var.cluster_name}-${local.tag_environment}-vault-dynamodb"
  description = "Vault DynamoDB backend policy"
  policy      = data.aws_iam_policy_document.vault_dynamodb_policy_document.json

  tags = var.common_tags
}

resource "aws_iam_role_policy_attachment" "vault_service_role_assume_policy_attachment" {
  role       = var.vault_service_role
  policy_arn = aws_iam_policy.vault_assume_policy.arn
}

resource "aws_iam_role_policy_attachment" "vault_service_role_kms_policy_attachment" {
  role       = var.vault_service_role
  policy_arn = aws_iam_policy.vault_kms_policy.arn
}

resource "aws_iam_role_policy_attachment" "vault_service_role_dynamodb_policy_attachment" {
  role       = var.vault_service_role
  policy_arn = aws_iam_policy.vault_dynamodb_policy.arn
}

resource "aws_iam_role_policy_attachment" "vault_agent_injector_service_role_assume_policy_attachment" {
  role       = var.vault_agent_injector_service_role
  policy_arn = aws_iam_policy.vault_assume_policy.arn
}

resource "aws_iam_role_policy_attachment" "vault_agent_injector_service_role_kms_policy_attachment" {
  role       = var.vault_agent_injector_service_role
  policy_arn = aws_iam_policy.vault_kms_policy.arn
}

resource "aws_iam_role_policy_attachment" "vault_agent_injector_service_role_dynamodb_policy_attachment" {
  role       = var.vault_agent_injector_service_role
  policy_arn = aws_iam_policy.vault_dynamodb_policy.arn
}