variable "common_tags" {
  type        = map(string)
  description = "tags configurations"
}

variable "bucket_name" {
  type        = string
  description = "S3 bucket name"
}

variable "s3_block_public_access" {
  type        = bool
  description = "True whenever public access to the bucket should be restricted (default true)"
  default     = true
}

variable "s3_encryption" {
  type        = string
  description = "S3 encryption (default enabled with AES256)"
  default     = "AES256"
}

variable "s3_versioning" {
  type        = string
  description = "S3 versioning (default disabled"
  default     = "Disabled"
}

variable "s3_default_bucket_policy" {
  type        = bool
  description = "True whenever default bucket policy should be applied (default true)"
  default     = true
}
