data "aws_iam_policy_document" "external_dns_oidc_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(var.oidc_eks_url, "https://", "")}:aud"
      values   = ["sts.amazonaws.com"]
    }

    principals {
      identifiers = [var.oidc_eks_arn]
      type        = "Federated"
    }
  }
}

data "aws_iam_policy_document" "external_dns_policy_document" {
  statement {
    actions = [
      "route53:ChangeResourceRecordSets",
    ]
    resources = ["arn:aws:route53:::hostedzone/${var.domain_zone_id}"]
  }

  statement {
    actions = [
      "route53:ListHostedZones",
      "route53:ListResourceRecordSets",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role" "external_dns_iam_service_role" {
  assume_role_policy = data.aws_iam_policy_document.external_dns_oidc_assume_role_policy.json
  name               = "${local.tag_environment}-external-dns-role-${var.eks_environment_name}"
  tags               = var.common_tags
}

resource "aws_iam_policy" "external_dns_policy" {
  name        = "${local.tag_environment}-external-dns-policy-${var.eks_environment_name}"
  description = "Permissions for External-DNS application"
  policy      = data.aws_iam_policy_document.external_dns_policy_document.json
  tags        = var.common_tags
}

resource "aws_iam_role_policy_attachment" "external_dns" {
  role       = aws_iam_role.external_dns_iam_service_role.name
  policy_arn = aws_iam_policy.external_dns_policy.arn
}
