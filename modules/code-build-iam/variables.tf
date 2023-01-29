variable "common_tags" {
  type        = map(string)
  description = "Tags configurations"
}

variable "aws_region" {
  type        = string
  description = "AWS Region"  
}

variable "subnet_list" {
  type        = list(string)
  description = "Subnet ids list"    
}

variable "eks_role_name" {
  type        = string
  description = "EKS Role name"  
}