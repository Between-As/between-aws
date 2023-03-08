resource "aws_eip" "nat_gateway" {
  for_each = var.vpc_nat_gateway_per_availability_zone ? toset(local.availability_zones) : toset([local.availability_zones[0]])

  vpc = true
  tags = {
    Name = format("%s-nat-gateway-%s", lower(local.tag_environment), substr(each.key, -2, 2))
  }
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_nat_gateway" "main" {
  for_each = var.vpc_nat_gateway_per_availability_zone ? toset(local.availability_zones) : toset([local.availability_zones[0]])

  subnet_id     = aws_subnet.public[each.key].id
  allocation_id = aws_eip.nat_gateway[each.key].id

  tags = {
    Name = format("%s-%s", lower(local.tag_environment), substr(each.key, -2, 2))
  }
}