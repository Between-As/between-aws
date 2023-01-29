variable "common_tags" {
  type        = map(string)
  description = "tags configurations"
}

variable "region" {
  type        = string
  description = "target region"
}

# VPC
variable "vpc_id" {
  type        = string
  description = "VPC ID"
}
variable "route_tables_list" {
  type        = list(any)
  description = "Route tables list"
}
variable "subnet_list" {
  type        = list(any)
  description = "Subnet list"
}

# SG
variable "security_group_ids_list" {
  type        = list(any)
  description = "Security ids list "
}
