resource "aws_subnet" "public" {
  for_each = toset(local.availability_zones)

  vpc_id            = aws_vpc.main.id
  availability_zone = each.key
  cidr_block        = var.public_subnets_cidrs[index(local.availability_zones, each.key)]

  tags = {
    Name = format("%s-public-%s", lower(local.tag_environment), substr(each.key, -2, 2))
  }
}

resource "aws_subnet" "private" {
  for_each = toset(local.availability_zones)

  vpc_id            = aws_vpc.main.id
  availability_zone = each.key
  cidr_block        = var.private_subnets_cidrs[index(local.availability_zones, each.key)]

  tags = {
    Name = format("%s-private-%s", lower(local.tag_environment), substr(each.key, -2, 2))
  }
}

resource "aws_subnet" "database" {
  for_each = toset(local.availability_zones)

  vpc_id            = aws_vpc.main.id
  availability_zone = each.key
  cidr_block        = var.database_subnets_cidrs[index(local.availability_zones, each.key)]

  tags = {
    Name = format("%s-db-%s", lower(local.tag_environment), substr(each.key, -2, 2))
  }
}