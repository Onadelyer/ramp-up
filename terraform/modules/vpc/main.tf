locals {
  vpc_cidr                    = var.vpc_cidr
  tags                        = var.tags
  name                        = var.name
  public_subnets_cidr_blocks  = var.public_subnets_cidr_blocks
  private_subnets_cidr_blocks = var.private_subnets_cidr_blocks
  azs                         = var.azs
}

resource "aws_vpc" "vpc" {
  cidr_block           = local.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = merge(local.tags, { Name = "${local.name}-vpc" })
}

resource "aws_subnet" "public" {
  count                   = length(local.public_subnets_cidr_blocks)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = local.public_subnets_cidr_blocks[count.index]
  availability_zone       = local.azs[count.index]
  map_public_ip_on_launch = true
  tags                    = merge(local.tags, { Name = "${local.name}-public-${count.index}" })
}

resource "aws_subnet" "private" {
  count             = length(local.private_subnets_cidr_blocks)
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = local.private_subnets_cidr_blocks[count.index]
  availability_zone = local.azs[count.index]
  tags              = merge(local.tags, { Name = "${local.name}-private-${count.index}" })
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.vpc.id
  tags   = merge(local.tags, { Name = "${local.name}-igw" })
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  tags   = merge(local.tags, { Name = "${local.name}-public-rt" })
}

resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

resource "aws_route_table_association" "public" {
  count          = length(aws_subnet.public)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}
