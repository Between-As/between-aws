module "ses" {
  source      = "../../modules/ses"
  common_tags = var.common_tags

  ses_domain = "izy.no"
  ses_email  = ["info", "post"]
}

module "ses_non_prod" {
  source      = "../../modules/ses"
  common_tags = var.common_tags

  providers = {
    aws = aws.non-prod
  }

  ses_domain = "izy.no"
  ses_email  = ["test-ses"]
}