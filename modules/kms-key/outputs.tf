output "id" {
  value = aws_kms_key.key.id
}

output "arn" {
  value = aws_kms_key.key.arn
}

output "autoscalling_role_name" {
  description = "Autoscaling role name"
  value       = aws_iam_service_linked_role.autoscaling.name
}

