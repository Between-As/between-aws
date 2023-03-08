variable "aws" {
  type        = map(any)
  description = "AWS credentials for terraform"
}

variable "common_tags" {
  type        = map(string)
  description = "tags configurations"
}

variable "route53_domains" {
  type        = map(any)
  description = "Zones configuration"
}

variable "oidc_eks_url_production" {
  type        = string
  description = "OIDC url from production EKS"
}

variable "oidc_eks_arn_production" {
  type        = string
  description = "OIDC arn from production EKS"
}

variable "oidc_eks_thumbprint_production" {
  type        = string
  description = "OIDC thumbprint from production EKS"
}

variable "oidc_eks_url_staging" {
  type        = string
  description = "OIDC url from staging EKS"
}

variable "oidc_eks_arn_staging" {
  type        = string
  description = "OIDC arn from staging EKS"
}

variable "oidc_eks_thumbprint_staging" {
  type        = string
  description = "OIDC thumbprint from staging EKS"
}

variable "oidc_eks_url_sandbox" {
  type        = string
  description = "OIDC url from sandbox EKS"
}

variable "oidc_eks_arn_sandbox" {
  type        = string
  description = "OIDC arn from sandbox EKS"
}

variable "oidc_eks_thumbprint_sandbox" {
  type        = string
  description = "OIDC thumbprint from sandbox EKS"
}

variable "between_as_domain_id" {
  type        = string
  description = "ID of Route53 domain"
}
