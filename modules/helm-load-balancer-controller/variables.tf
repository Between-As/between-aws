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

variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
}
