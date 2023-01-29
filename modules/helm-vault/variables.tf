variable "release_name" {
  type = string
}

variable "namespace" {
  type = string
}

variable "repository" {
  type = string
}

variable "chart_name" {
  type = string
}

variable "chart_version" {
  type = string
}

variable "isAtomic" {
  type    = bool
  default = true
}

variable "dynamodb_table_name" {
  type = string
}

variable "kms_key" {
  type = string
}

variable "iam_vault_service_role" {
  type = string
}

variable "iam_vault_agent_injector_service_role" {
  type = string
}
