variable "common_tags" {
  type        = map(string)
  description = "Tags configurations"
}

variable "codebuild_configuration" {
  type        = map(any)
  description = "Pipeline configurations map"
}

variable "service_role_arn" {
  type        = string
  description = "Codebuild role ARN"
}

variable "environment_variable_parameter_store_keys" {
  type = map(any)
}

variable "aws_region" {
  type        = string
  description = "EKS region"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "subnet_list" {
  type        = list(string)
  description = "Subnets list"    
}

variable "codebuild_security_group" {
  type        = string
  description = "Security group for CodeBuild"    
}