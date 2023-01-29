resource "aws_vpc_endpoint" "s3" {
  vpc_id          = var.vpc_id
  service_name    = "com.amazonaws.${var.region}.s3"
  route_table_ids = var.route_tables_list
  tags = {
    Name = format("s3-vpc-endpoint-%s", lower(local.tag_environment))
  }
}

resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id              = var.vpc_id
  private_dns_enabled = true
  vpc_endpoint_type   = "Interface"
  service_name        = "com.amazonaws.${var.region}.ecr.dkr"
  security_group_ids  = var.security_group_ids_list
  subnet_ids          = var.subnet_list
  tags = {
    Name = format("ecr-dkr-vpc-endpoint-%s", lower(local.tag_environment))
  }
}

resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id              = var.vpc_id
  private_dns_enabled = true
  vpc_endpoint_type   = "Interface"
  service_name        = "com.amazonaws.${var.region}.ecr.api"
  security_group_ids  = var.security_group_ids_list
  subnet_ids          = var.subnet_list
  tags = {
    Name = format("ecr-dkr-vpc-endpoint-%s", lower(local.tag_environment))
  }
}

resource "aws_vpc_endpoint" "codebuild" {
  vpc_id              = var.vpc_id
  private_dns_enabled = true
  vpc_endpoint_type   = "Interface"
  service_name        = "com.amazonaws.${var.region}.codebuild"
  security_group_ids  = var.security_group_ids_list
  subnet_ids          = var.subnet_list
  tags = {
    Name = format("codebuild-vpc-endpoint-%s", lower(local.tag_environment))
  }
}