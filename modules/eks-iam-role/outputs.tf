output "arn" {
  value = aws_iam_role.eks_iam_service_role.arn
}

output "name" {
  value = aws_iam_role.eks_iam_service_role.name
}
