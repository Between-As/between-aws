output "dynamodb_table_arn" {
  value = aws_dynamodb_table.vault_table.arn
}

output "dynamodb_table_name" {
  value = aws_dynamodb_table.vault_table.id
}

output "kms_key_arn" {
  value = aws_kms_key.vault-key.arn
}