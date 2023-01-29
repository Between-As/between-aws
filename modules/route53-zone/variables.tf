variable "domain_name" {
  type        = string
  description = "Route53 zone name"
}

variable "force_destroy" {
  type        = bool
  description = "whether to destroy all records in the zone when destroying the zone"
}

variable "is_internal" {
  type        = bool
  description = "true if zone is internal"
  default     = false
}

variable "vpc_id" {
  type        = string
  description = "VPC id"
  default     = ""
}

variable "common_tags" {
  type        = map(string)
  description = "tags configurations"
}