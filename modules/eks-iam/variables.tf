variable "common_tags" {
  type        = map(string)
  description = "tags configurations"
}

variable "cluster_name" {
  type = string
}

variable "region" {
  type    = string
  default = "eu-north-1"
}

variable "operator_principals" {
  type = list(string)
}

variable "readonly_principals" {
  type = list(string)
}

variable "node_kms_key_arn" {
  type = string
}

variable "autoscalling_role_name" {
  type = string
}
