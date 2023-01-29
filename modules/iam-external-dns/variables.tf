variable "domain_zone_id" {
  type        = string
  description = "ID of the domain zone"
}

variable "oidc_eks_url" {
  type        = string
  description = "OIDC url from EKS"
}

variable "oidc_eks_arn" {
  type        = string
  description = "OIDC arn from EKS"
}

variable "eks_environment_name" {
  type        = string
  description = "EKS environment name"
}

variable "common_tags" {
  type        = map(string)
  description = "tags configurations"
}
