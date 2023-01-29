resource "aws_security_group" "aurora_pg_cluster" {
  name        = "${local.tag_environment}-aurora-pg-cluster-sg"
  description = "Aurora PostgreSQL access"
  vpc_id      = var.vpc_id

  tags = merge(
    {
      "Name" = "${local.tag_environment}-aurora-pg-cluster-sg"
    },
    var.common_tags
  )
}

resource "aws_security_group_rule" "aurora_pg_cluster_ingress" {
  type        = "ingress"
  description = "Allow intergroup communication"

  security_group_id        = aws_security_group.aurora_pg_cluster.id
  source_security_group_id = aws_security_group.aurora_pg_cluster.id

  protocol  = "tcp"
  from_port = 5432
  to_port   = 5432
}

resource "aws_security_group_rule" "aurora_pg_cluster_ingress_for_eks_cluster" {
  type        = "ingress"
  description = "Allow communication with EKS cluster"

  security_group_id        = aws_security_group.aurora_pg_cluster.id
  source_security_group_id = var.eks_cluster_security_group_id

  protocol  = "tcp"
  from_port = 5432
  to_port   = 5432
}

resource "aws_security_group_rule" "aurora_pg_cluster_ingress_for_rds_access" {
  type        = "ingress"
  description = "Allow communication with EC2"

  security_group_id        = aws_security_group.aurora_pg_cluster.id
  source_security_group_id = var.rds_access_security_group_id

  protocol  = "tcp"
  from_port = 5432
  to_port   = 5432
}

resource "aws_security_group_rule" "aurora_pg_cluster_ingress_for_codebuild" {
  type        = "ingress"
  description = "Allow communication with CodeBuild"

  security_group_id        = aws_security_group.aurora_pg_cluster.id
  source_security_group_id = var.codebuild_security_group_id

  protocol  = "tcp"
  from_port = 5432
  to_port   = 5432
}

resource "aws_security_group_rule" "aurora_pg_cluster_egress" {
  type        = "egress"
  description = "Allow group to Internet connection"

  security_group_id = aws_security_group.aurora_pg_cluster.id
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]

  protocol  = "-1"
  from_port = 0
  to_port   = 65535
}
