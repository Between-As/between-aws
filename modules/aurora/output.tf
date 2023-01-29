# resource "aws_rds_cluster" "aurora_postgres" 
output "aurora_user" {
  value = var.aurora_postgres_master_username
}

output "aurora_password" {
  value = random_string.aurora_postgres_master_password.result
}

output "aurora_endpoint" {
  value = aws_rds_cluster.aurora_postgres.endpoint
}

output "aurora_security_group_id" {
  value = aws_security_group.aurora_pg_cluster.id
}

###########

# aws_rds_cluster
output "aurora_rds_cluster_arn" {
  description = "The ID of the cluster"
  value       = element(concat(aws_rds_cluster.aurora_postgres.*.arn, [""]), 0)
}

output "aurora_rds_cluster_id" {
  description = "The ID of the cluster"
  value       = element(concat(aws_rds_cluster.aurora_postgres.*.id, [""]), 0)
}

output "aurora_rds_cluster_resource_id" {
  description = "The Resource ID of the cluster"
  value       = element(concat(aws_rds_cluster.aurora_postgres.*.cluster_resource_id, [""]), 0)
}

output "aurora_rds_cluster_endpoint" {
  description = "The cluster endpoint"
  value       = element(concat(aws_rds_cluster.aurora_postgres.*.endpoint, [""]), 0)
}

output "aurora_rds_cluster_engine_version" {
  description = "The cluster engine version"
  value       = element(concat(aws_rds_cluster.aurora_postgres.*.engine_version, [""]), 0)
}

output "aurora_rds_cluster_reader_endpoint" {
  description = "The cluster reader endpoint"
  value       = element(concat(aws_rds_cluster.aurora_postgres.*.reader_endpoint, [""]), 0)
}

output "aurora_rds_cluster_master_password" {
  description = "The master password"
  value       = element(concat(aws_rds_cluster.aurora_postgres.*.master_password, [""]), 0)
  sensitive   = true
}

output "aurora_rds_cluster_port" {
  description = "The port"
  value       = element(concat(aws_rds_cluster.aurora_postgres.*.port, [""]), 0)
}

output "aurora_rds_cluster_master_username" {
  description = "The master username"
  value       = element(concat(aws_rds_cluster.aurora_postgres.*.master_username, [""]), 0)
  sensitive   = true
}

output "aurora_rds_cluster_hosted_zone_id" {
  description = "Route53 hosted zone id of the created cluster"
  value       = element(concat(aws_rds_cluster.aurora_postgres.*.hosted_zone_id, [""]), 0)
}

# aws_rds_cluster_instance
output "aurora_rds_cluster_instance_endpoints" {
  description = "A list of all cluster instance endpoints"
  value       = aws_rds_cluster.aurora_postgres.*.endpoint
}

output "aurora_rds_cluster_instance_ids" {
  description = "A list of all cluster instance ids"
  value       = aws_rds_cluster.aurora_postgres.*.id
}
