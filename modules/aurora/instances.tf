resource "aws_rds_cluster_instance" "postgres" {
  count = var.aurora_postgres_instances

  engine = var.aurora_engine_family

  instance_class               = var.aurora_postgres_instance_class
  identifier                   = "${local.tag_environment}-pg-cluster-${count.index + 1}"
  cluster_identifier           = aws_rds_cluster.aurora_postgres.id
  publicly_accessible          = var.aurora_postgres_publicly_accessible
  db_subnet_group_name         = aws_db_subnet_group.postgres.id
  db_parameter_group_name      = aws_db_parameter_group.postgres.id
  performance_insights_enabled = var.aurora_postgres_performance_insights_enabled
  apply_immediately            = var.aurora_postgres_apply_immediately
}
