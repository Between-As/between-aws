resource "aws_rds_cluster" "aurora_postgres" {
  cluster_identifier        = "${local.tag_environment}-pg-cluster"
  final_snapshot_identifier = "${local.tag_environment}-pg-cluster-final-snapshot-${md5(timestamp())}"
  engine                    = var.aurora_engine_family

  engine_version = var.aurora_engine_version
  engine_mode    = "provisioned"
  port           = var.aurora_postgres_port

  vpc_security_group_ids = [
    aws_security_group.aurora_pg_cluster.id
  ]

  master_username = var.aurora_postgres_master_username
  master_password = random_string.aurora_postgres_master_password.result

  db_subnet_group_name            = aws_db_subnet_group.postgres.id
  db_cluster_parameter_group_name = aws_rds_cluster_parameter_group.postgres.id
  skip_final_snapshot             = var.aurora_postgres_skip_final_snapshot
  backup_retention_period         = var.aurora_postgres_backup_retention_period
  preferred_backup_window         = var.aurora_postgres_preferred_backup_window
  preferred_maintenance_window    = var.aurora_postgres_preferred_maintenance_window
  enabled_cloudwatch_logs_exports = var.aurora_postgres_cloudwatch_logs_exports
  storage_encrypted               = var.aurora_postgres_storage_encrypted
  deletion_protection             = var.aurora_postgres_deletion_protection
  apply_immediately               = var.aurora_postgres_apply_immediately


  lifecycle {
    ignore_changes = [final_snapshot_identifier]
  }

  tags = merge(
    var.common_tags,
    {
      "Name" = "${local.tag_environment}-postgres-cluster"
    }
  )
}
