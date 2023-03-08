output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = [for subnet in aws_subnet.public : subnet.id]
}

output "public_subnet_ids_map" {
  value = {
    for az, subnet in aws_subnet.public : az => subnet.id
  }
}

output "private_subnet_ids" {
  value = [for subnet in aws_subnet.private : subnet.id]
}

output "private_subnet_ids_map" {
  value = {
    for az, subnet in aws_subnet.private : az => subnet.id
  }
}

output "database_subnet_ids" {
  value = [for subnet in aws_subnet.database : subnet.id]
}

output "database_subnet_ids_map" {
  value = {
    for az, subnet in aws_subnet.database : az => subnet.id
  }
}

output "az_count" {
  value = var.availability_zones
}

output "security_groups" {
  value = aws_security_group.main
}

output "ngw_ids_map" {
  value = {
    for az, ngw in aws_nat_gateway.main : az => ngw.id
  }
}

output "private_route_table_ids" {
  value = [for route_table in aws_route_table.private : route_table.id]
}

output "codebuild_security_group_id" {
  value = aws_security_group.codebuild_sg.id
}

output "rds_access_security_group_id" {
  value = aws_security_group.rds_access_sg.id
}

/*output "vault_access_security_group_id" {
  value = aws_security_group.vault_access_sg.id
}*/
