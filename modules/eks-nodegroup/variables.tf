variable "common_tags" {
  type        = map(string)
  description = "tags configurations"
}

variable "cluster_name" {
  type        = string
  description = "EKS Cluster name"
}

variable "node_role_arn" {
  type        = string
  description = "EKS Node Role ARN"
}

variable "node_subnet_ids" {
  type        = list(any)
  description = "Subnet ids to create nodes in"
}

variable "disk_size" {
  type        = number
  default     = 100
  description = "Node local disk size"
}

variable "instance_type" {
  type        = string
  default     = "t3.medium"
  description = "Node instance type"
}

variable "labels" {
  type        = map(any)
  default     = {}
  description = "Labels to give to node pool"
}

variable "capacity_type" {
  type        = string
  default     = "ON_DEMAND"
  description = "ON_DEMAND or SPOT"
}

variable "min_capacity" {
  type        = number
  default     = 1
  description = "Minimum pool capacity"
}

variable "max_capacity" {
  type        = number
  default     = 4
  description = "Maximum pool capacity"
}

variable "desired_capacity" {
  type        = number
  default     = 2
  description = "Desired (initial) pool capacity"
}

variable "volume_encryption" {
  type        = bool
  default     = true
  description = "True for volume encryption"
}

variable "node_kms_key_arn" {
  type        = string
  description = "Node KMS key arn"
  default     = ""
}
