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
