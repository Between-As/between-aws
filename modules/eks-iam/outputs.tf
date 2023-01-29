output "eks_role_name" {
  description = "Cluster role name"
  value       = aws_iam_role.eks_role.name
}

output "eks_role_arn" {
  description = "Cluster role ARN"
  value       = aws_iam_role.eks_role.arn
}

output "eks_worker_arn" {
  description = "Cluster worker role ARN"
  value       = aws_iam_role.worker.arn
}

output "eks_worker_instance_profile_arn" {
  description = "Cluster worker instance profile ARN"
  value       = aws_iam_instance_profile.instance_profile.arn
}
