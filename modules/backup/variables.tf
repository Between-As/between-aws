variable "common_tags" {
  type        = map(string)
  description = "tags configurations"
}

variable "backuped_resources" {
  type        = list(any)
  default     = []
  description = "Resources to backup"
}

variable "lifecycle_retention" {
  type        = number
  default     = 7
  description = "Backup retention"
}

variable "schedule" {
  type        = string
  default     = "cron(0 2 * * ? *)"
  description = "Backup schedule"
}
