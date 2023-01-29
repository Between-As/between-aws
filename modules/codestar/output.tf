output "codestar_connection_arn" {
  value       = aws_codestarconnections_connection.github_connection.arn
  description = "Codestar connection arn (Remember to import it)"
}