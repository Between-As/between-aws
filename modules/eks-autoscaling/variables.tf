variable "common_tags" {
  type        = map(string)
  description = "tags configurations"
}

variable "service_name" {
  type        = string
  description = "service name"
}

variable "replica_min_size" {
  type        = number
  default     = 2
  description = "replica min size"
}

variable "replica_max_size" {
  type        = number
  default     = 50
  description = "replica max size"
}

variable "average_utilization" {
  type        = number
  default     = 50
  description = "deployment average utilization"
}