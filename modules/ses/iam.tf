data "aws_iam_policy_document" "ses_policy" {
  statement {
    actions   = ["ses:SendRawEmail"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "ses_policy" {
  name        = "${title(local.tag_environment)}AmazonSesSendingAccess-${random_string.random_suffix.result}"
  description = "Allows sending of e-mails via SES"
  policy      = data.aws_iam_policy_document.ses_policy.json
}

resource "aws_iam_user" "smtp_user" {
  name = "${local.tag_environment}-${var.ses_domain}-smtp-user-${random_string.random_suffix.result}"
}

resource "aws_iam_user_policy_attachment" "ses_policy" {
  user       = aws_iam_user.smtp_user.name
  policy_arn = aws_iam_policy.ses_policy.arn
}

resource "aws_iam_access_key" "smtp_user" {
  user = aws_iam_user.smtp_user.name
}
