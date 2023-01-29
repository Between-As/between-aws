resource "aws_ses_domain_identity" "ses_domain" {
  domain = var.ses_domain
}

resource "aws_ses_email_identity" "ses_email" {
  for_each = toset(var.ses_email)
  email    = "${each.key}@${var.ses_domain}"
}