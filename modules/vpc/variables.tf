variable "common_tags" {
  type        = map(string)
  description = "tags configurations"
}

variable "region" {
  type        = string
  description = "target region"
}

# VPC
variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR"
}

variable "public_subnets_cidrs" {
  type        = list(any)
  description = "Public subnets CIDRs"
}

variable "private_subnets_cidrs" {
  type        = list(any)
  description = "Private subnets CIDRs"
}

variable "database_subnets_cidrs" {
  type        = list(any)
  description = "DB subnets CIDRs"
}

variable "availability_zones" {
  type        = number
  description = "How many AZ should be used"
}

variable "vpc_nat_gateway_per_availability_zone" {
  type        = bool
  description = "True whenever terraform should create separate NGW per az (default false)"
  default     = false
}

# SG
variable "security_groups" {
  type        = map(any)
  description = "Security group map"
}

variable "flow_log_bucket_name" {
  type        = string
  description = "Flow log bucket name"
}
variable "flow_log_bucket_arn" {
  type        = string
  description = "Flow log bucket arn"
} 