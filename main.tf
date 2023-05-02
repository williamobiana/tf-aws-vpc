
// VPC

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = merge(
    local.default_tags,
    { Name = "${local.prefix}-vpc" }
  )
}

// Networking Resources

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = merge(
    local.default_tags,
    { Name = "${local.prefix}-igw" }
  )
}

resource "aws_eip" "eip" {
  tags = merge(
    local.default_tags,
    { Name = "${local.prefix}-ngw-eip" }
  )
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.eip.id
  subnet_id     = aws_subnet.public[0].id
  tags = merge(
    local.default_tags,
    { Name = "${local.prefix}-ngw" }
  )
}

resource "aws_vpc_endpoint" "s3" {
  route_table_ids = [
    aws_route_table.private.id,
    aws_route_table.public.id
  ]
  service_name = "com.amazonaws.${data.aws_region.current.id}.s3"
  vpc_id       = aws_vpc.vpc.id
  tags = merge(
    local.default_tags,
    { Name = "${local.prefix}-s3-gw-endpoint" }
  )
}

// Subnets

resource "aws_subnet" "private" {
  count = length(var.private_cidr_blocks)

  availability_zone       = count.index % 2 == 0 ? data.aws_availability_zones.available.names[0] : data.aws_availability_zones.available.names[1]
  cidr_block              = var.private_cidr_blocks[count.index]
  map_public_ip_on_launch = false
  vpc_id                  = aws_vpc.vpc.id
  tags = merge(
    var.private_subnet_tags,
    local.default_tags,
    { Name = "${local.prefix}-private" }
  )
}

resource "aws_subnet" "public" {
  count = length(var.public_cidr_blocks)

  availability_zone       = count.index % 2 == 0 ? data.aws_availability_zones.available.names[0] : data.aws_availability_zones.available.names[1]
  cidr_block              = var.public_cidr_blocks[count.index]
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.vpc.id
  tags = merge(
    var.public_subnet_tags,
    local.default_tags,
    { Name = "${local.prefix}-public" }
  )
}

// Route Tables

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id
  tags = merge(
    local.default_tags,
    { Name = "${local.prefix}-private" }
  )
}

resource "aws_route" "ngw" {
  count                  = var.create_default_routes ? 1 : 0

  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.ngw.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  tags = merge(
    local.default_tags,
    { Name = "${local.prefix}-public" }
  )
}

resource "aws_route" "igw" {
  count                  = var.create_default_routes ? 1 : 0

  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "private" {
  count = length(var.private_cidr_blocks)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "public" {
  count = length(var.public_cidr_blocks)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

// Security Group

resource "aws_security_group" "default" {
  name        = "${local.prefix}-default-sg"
  description = "Default SG for VPC which provides 80/443 egress."
  vpc_id      = aws_vpc.vpc.id

  egress {
    description = "Outbound HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "Outbound HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    local.default_tags,
    { "Name" : "${local.prefix}-default-sg" }
  )
}

// Flow Log

resource "aws_flow_log" "flow_log" {
  log_destination      = var.s3_flow_log_bucket_arn == null ? "arn:aws:s3:::acp-vpc-flowlogs-${data.aws_caller_identity.current.id}-bucket" : var.s3_flow_log_bucket_arn
  log_destination_type = "s3"
  traffic_type         = "ALL"
  vpc_id               = aws_vpc.vpc.id
}
