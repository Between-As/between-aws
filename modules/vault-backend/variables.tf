variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
}

variable "dynamodb_table_name" {
  type        = string
  description = "DynamoDB table name"
}

/*variable "read_capacity" {
  type        = number
  description = "DynamoDB read capacity units"
}

variable "write_capacity" {
  type        = number
  description = "DynamoDB write capacity units"
}*/

variable "common_tags" {
  type        = map(string)
  description = "tags configurations"
}

variable "vault_service_role" {
  type        = string
  description = "ServiceAccount role arn"
}

variable "vault_agent_injector_service_role" {
  type        = string
  description = "ServiceAccount role arn"
}
