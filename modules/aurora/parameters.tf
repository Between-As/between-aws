resource "aws_db_parameter_group" "postgres" {
  name   = "${local.tag_environment}-postgres-pg"
  family = var.aurora_parameter_group_family
}

resource "aws_db_subnet_group" "postgres" {
  name       = "${local.tag_environment}-postgres-sg"
  subnet_ids = var.aurora_subnets_list
}

resource "aws_rds_cluster_parameter_group" "postgres" {
  name   = "${local.tag_environment}-postgres-cpg"
  family = var.aurora_parameter_group_family
}
