resource "aws_codestarconnections_connection" "github_connection" {
  name          = var.connection_name
  provider_type = "GitHub"
}