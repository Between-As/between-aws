resource "aws_ssm_parameter" "postgres_host" {
  name  = "/${local.tag_environment}-${var.name}/AURORA_POSTGRESHOST"
  type  = "String"
  value = aws_rds_cluster.aurora_postgres.endpoint

  tags = merge(
    {
      "Accessibility" = "Read-only",
    },
  var.common_tags)
}

resource "aws_ssm_parameter" "postgres_port" {
  name  = "/${local.tag_environment}-${var.name}/AURORA_POSTGRESPORT"
  type  = "String"
  value = var.aurora_postgres_port

  tags = merge(
    {
      "Accessibility" = "Read-only",
    },
  var.common_tags)
}

resource "aws_ssm_parameter" "postgres_master_user" {
  name  = "/${local.tag_environment}-${var.name}/AURORA_POSTGRESUSER"
  type  = "String"
  value = var.aurora_postgres_master_username

  tags = merge(
    {
      "Accessibility" = "Read-only",
    },
  var.common_tags)
}

resource "aws_ssm_parameter" "postgres_master_pass" {
  name  = "/${local.tag_environment}-${var.name}/AURORA_POSTGRESPASS"
  type  = "SecureString"
  value = random_string.aurora_postgres_master_password.result

  tags = merge(
    {
      "Accessibility" = "Read-only",
    },
  var.common_tags)
}
