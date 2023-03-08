module "network" {
  source      = "../../modules/vpc"
  common_tags = var.common_tags
  region      = var.aws.region

  # VPC
  vpc_cidr = "10.10.0.0/16"
  private_subnets_cidrs = [
    "10.10.0.0/23",
    "10.10.2.0/23",
    "10.10.4.0/23"
  ]
  public_subnets_cidrs = [
    "10.10.10.0/23",
    "10.10.12.0/23",
    "10.10.14.0/23"
  ]

  database_subnets_cidrs = [
    "10.10.20.0/23",
    "10.10.22.0/23",
    "10.10.24.0/23"
  ]

  availability_zones                    = 3
  vpc_nat_gateway_per_availability_zone = false

  # SG
  security_groups = var.security_groups

  # Monitoring
  flow_log_bucket_name = module.vpc_flow_log.s3_bucket_name
  flow_log_bucket_arn  = module.vpc_flow_log.s3_bucket_arn

  depends_on = [module.vpc_flow_log]
}

module "network_endpoints" {
  source      = "../../modules/vpc-endpoints"
  common_tags = var.common_tags
  region      = var.aws.region

  vpc_id                  = module.network.vpc_id
  security_group_ids_list = [module.network.security_groups["vpc-endpoint"].id]
  subnet_list             = module.network.private_subnet_ids
  route_tables_list       = module.network.private_route_table_ids

  depends_on = [module.network]
}

# module "network_security_monitoring" {
#   source      = "../../modules/vpc-security-monitoring"
#   common_tags = var.common_tags
#   env_name    = "dev"

#   #Monitoring
#   cloudtrail_log_group_name = "Cloudtrail/Hostersi"
#   sns_arn                   = var.sns_events_arn
#   depends_on                = [module.network]
# }