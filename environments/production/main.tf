module "aurora" {
  source      = "../../modules/aurora"
  common_tags = var.common_tags

  vpc_id                                       = module.network.vpc_id
  aurora_subnets_list                          = values(module.network.database_subnet_ids_map)
  aurora_engine_family                         = var.aurora_engine_family
  aurora_engine_version                        = var.aurora_engine_version
  aurora_parameter_group_family                = var.aurora_parameter_group_family
  aurora_postgres_port                         = var.aurora_postgres_port
  aurora_postgres_master_username              = var.aurora_postgres_master_username
  aurora_postgres_skip_final_snapshot          = var.aurora_postgres_skip_final_snapshot
  aurora_postgres_backup_retention_period      = var.aurora_postgres_backup_retention_period
  aurora_postgres_preferred_backup_window      = var.aurora_postgres_preferred_backup_window
  aurora_postgres_preferred_maintenance_window = var.aurora_postgres_preferred_maintenance_window
  aurora_postgres_cloudwatch_logs_exports      = var.aurora_postgres_cloudwatch_logs_exports
  aurora_postgres_storage_encrypted            = var.aurora_postgres_storage_encrypted
  aurora_postgres_deletion_protection          = var.aurora_postgres_deletion_protection
  aurora_postgres_apply_immediately            = var.aurora_postgres_apply_immediately
  aurora_postgres_instances                    = var.aurora_postgres_instances
  aurora_postgres_instance_class               = var.aurora_postgres_instance_class
  aurora_postgres_publicly_accessible          = var.aurora_postgres_publicly_accessible
  aurora_postgres_performance_insights_enabled = var.aurora_postgres_performance_insights_enabled
  aurora_postgres_master_password_seed         = "TbTmkvN9EQAiRmaUKswZ"
  eks_cluster_security_group_id                = module.eks_cluster.eks_security_group_id
  codebuild_security_group_id                  = module.network.codebuild_security_group_id
  rds_access_security_group_id                 = module.network.rds_access_security_group_id
}


module "vault_backend" {
  source      = "../../modules/vault-backend"
  common_tags = var.common_tags

  cluster_name                      = module.eks_cluster.cluster_name
  dynamodb_table_name               = var.vault_dynamodb_name
  #read_capacity                     = var.vault_dynamodb_read_capacity
  #write_capacity                    = var.vault_dynamodb_write_capacity
  vault_service_role                = module.eks_iam_roles["vault"].name
  vault_agent_injector_service_role = module.eks_iam_roles["vault-agent-injector"].name

  depends_on = [module.eks_cluster]
}


module "route53_zone" {
  source      = "../../modules/route53-zone"
  common_tags = var.common_tags

  for_each = var.route53_domains

  domain_name   = each.value["domain_name"]
  force_destroy = each.value["force_destroy"]
  is_internal   = each.value["is_internal"]
  vpc_id        = module.network.vpc_id
}


module "aws_backup" {
  source = "../../modules/backup"

  for_each = {
    "daily" = {
      backuped_resources  = [module.vault_backend.dynamodb_table_arn]
      lifecycle_retention = 7
      schedule            = "cron(0 2 * * ? *)"
    }
  }

  backuped_resources  = each.value["backuped_resources"]
  lifecycle_retention = each.value["lifecycle_retention"]
  schedule            = each.value["schedule"]
  common_tags         = var.common_tags

  depends_on = [module.vault_backend]
}


module "loki_backend" {
  source      = "../../modules/loki-backend"
  common_tags = var.common_tags

  cluster_name  = module.eks_cluster.cluster_name
  aws_region    = var.aws.region
  service_role  = module.eks_iam_roles["loki"].name
  s3_bucket_arn = module.s3_loki_storage.s3_bucket_arn

  depends_on = [module.eks_cluster, module.eks_iam_roles["loki"], module.s3_loki_storage]
}

module "cloudwatch" {
  source = "../../modules/cloudwatch"
  
  common_tags          = var.common_tags
  cluster_name         = module.eks_cluster.cluster_name
  grafana_service_role = module.eks_iam_roles["grafana"].name

  depends_on = [module.eks_cluster, module.eks_iam_roles["grafana"]]
}
