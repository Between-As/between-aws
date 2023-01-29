resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = format("%s-public", lower(local.tag_environment))
  }
}

resource "aws_route_table" "private" {
  for_each = toset(local.availability_zones)

  vpc_id = aws_vpc.main.id

  tags = {
    Name = format("%s-private-%s", lower(local.tag_environment), substr(each.key, -2, 2))
  }
}

resource "aws_route_table_association" "public" {
  for_each = toset(local.availability_zones)

  subnet_id      = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  for_each = toset(local.availability_zones)

  subnet_id      = aws_subnet.private[each.key].id
  route_table_id = aws_route_table.private[each.key].id
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

resource "aws_route" "private_nat_gateway" {
  for_each = toset(local.availability_zones)

  route_table_id         = aws_route_table.private[each.key].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = var.vpc_nat_gateway_per_availability_zone ? aws_nat_gateway.main[each.key].id : aws_nat_gateway.main[local.availability_zones[0]].id
}