variable "domain_name" {
  type        = string
  description = "Domain name"
}

variable "service_name" {
  type        = string
  description = "Name of the service"
}

variable "service_port" {
  type        = number
  description = "Port of the service to which connect ingress"
}

variable "path" {
  type        = string
  description = "Path"
}

variable "path_type" {
  type        = string
  description = "Path type"
}

variable "name" {
  type        = string
  description = "Ingress name"
}

variable "namespace" {
  type        = string
  description = "Namespace name"
}

variable "group_name" {
  type        = string
  description = "Ingress name"
}

variable "ports" {
  type        = string
  description = "ALB ports"
}

variable "lb_target_type" {
  type        = string
  description = "Load balancer target type"
  default     = "ip"
}

variable "is_internal" {
  type        = bool
  description = "True for internal ALB"
  default     = false
}

variable "healthcheck_path" {
  type        = string
  description = "Healthcheck path"
  default     = "ip"
}

variable "healthcheck_success_codes" {
  type        = string
  description = "Healthcheck success codes"
  default     = "ip"
}

variable "subnets" {
  type        = list(any)
  description = "IDs of subnets connected to ALB"
}

variable "security_groups" {
  type        = list(any)
  description = "IDs of security groups on ALB"
}

variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
}

variable "common_tags" {
  type        = map(string)
  description = "tags configurations"
}
