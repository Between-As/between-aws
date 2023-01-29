variable "common_tags" {
  type        = map(string)
  description = "tags configurations"
}

variable "parameter_store_keys" {
  type = map(any)
}

variable "prefix" {
  type = string
  description = "Application prefix"  
}