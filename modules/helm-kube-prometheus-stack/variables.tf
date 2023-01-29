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

variable "iam_service_role" {
  type = string
}

variable "admin_password" {
  type = string
}

variable "grafana_certificate" {
  type = string
}

variable "grafana_group_name" {
  type = string
}

variable "grafana_subnets" {
  type = string
}

variable "grafana_domain" {
  type = string
}

variable "prometheus_certificate" {
  type = string
}

variable "prometheus_group_name" {
  type = string
}

variable "prometheus_subnets" {
  type = string
}

variable "prometheus_domain" {
  type = string
}
