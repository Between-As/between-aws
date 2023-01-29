variable "description" {
  type        = string
  description = "Describe your key"
  default     = "Terraformed key"
}

variable "deletion_days" {
  type        = number
  description = "Days to deletion"
  default     = 7
}

variable "enable_key_rotation" {
  type        = bool
  description = "Enable rotation"
  default     = false
}

variable "common_tags" {
  type    = map(any)
  default = {}
}

variable "alias" {
  type = string
}

variable "add_autoscaling_permissions" {
  type        = bool
  description = "True if will be used for autoscaling linked service"
  default     = false
}
