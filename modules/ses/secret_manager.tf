resource "aws_secretsmanager_secret" "ses_credentials" {
  name = "${local.tag_environment}-ses-credentials"
}

resource "aws_secretsmanager_secret_version" "ses_credentials" {
  secret_id = aws_secretsmanager_secret.ses_credentials.id
  secret_string = jsonencode({
    smtp_user     = aws_iam_access_key.smtp_user.id
    smtp_password = aws_iam_access_key.smtp_user.ses_smtp_password_v4
  })
}