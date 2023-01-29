variable "common_tags" {
  type        = map(string)
  description = "Tags configurations"
}

variable "pipeline_configuration" {
  type        = map(any)
  description = "Pipeline configurations map"
}

variable "pipeline_role_arn" {
  type        = string
  description = "Pipeline role ARN"
  default     = ""
}

variable "artifact_bucket" {
  type        = string
  description = "Artifacts bucket name"
}

variable "codestar_connection_arn" {
  type        = string
  description = "Github integration connections arn"
}