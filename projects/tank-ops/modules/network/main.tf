/*
  * VPC
*/

resource "aws_vpc" "this" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "Main virtual private networks"
  }
}

locals {
  vpc_id = aws_vpc.this.id
}

/*
  * IGW
*/

resource "aws_internet_gateway" "this" {
  vpc_id = local.vpc_id

  tags = {
    Description = "Main IGW for public subnet"
  }

  depends_on = [aws_vpc.this]
}

/*
  * SUBNETS
*/

resource "aws_subnet" "public" {
  vpc_id                  = local.vpc_id
  count                   = length(var.public_subnets)
  cidr_block              = var.public_subnets[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = true

  tags = {
    Description = "Main public subnet in VPC"
  }

  depends_on = [aws_internet_gateway.this]
}

resource "aws_subnet" "private" {
  vpc_id                  = local.vpc_id
  count                   = length(var.private_subnets)
  cidr_block              = var.private_subnets[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = false

  tags = {
    Description = "Main private subnet in VPC"
  }

  depends_on = [aws_internet_gateway.this]
}

/*
  * ROUTE TABLES
*/

resource "aws_route_table" "public" {
  vpc_id = local.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Description = "Route table for public subnets"
  }
}

resource "aws_route_table" "private" {
  vpc_id = local.vpc_id

  tags = {
    Description = "Route table for private subnets"
  }
}

resource "aws_route_table_association" "public" {
  count          = 2
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count          = 2
  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}

/*
  * ELASTIC IPs
*/

resource "aws_eip" "vm_ip" {
  tags = {
    Description = "Elastic IP for EC2 instance"
  }

  lifecycle {
    create_before_destroy = true
  }
}

/*
  * NETWORK INTERFACE
*/

resource "aws_network_interface" "ec2_nic" {
  subnet_id = aws_subnet.public[0].id

  tags = {
    Description = "This is supposed to be attached to main EC2 instance"
  }
}
