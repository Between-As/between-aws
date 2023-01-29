variable "common_tags" {
  type        = map(string)
  description = "tags configurations"
}

variable "ses_domain" {
  type        = string
  description = "SES domain identity"
}

variable "ses_email" {
  type        = list(string)
  description = "SES email identity"
}