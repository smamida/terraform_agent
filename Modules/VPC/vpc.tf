resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "test-vpc"
  }
}

resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = var.availability_zones[0]
  cidr_block              = var.public_subnet_cidrs[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "test-public_subnet1"
  }
}

resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = var.availability_zones[1]
  cidr_block              = var.public_subnet_cidrs[1]
  map_public_ip_on_launch = true
  tags = {
    Name = "test-public_subnet2"
  }
}

resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.availability_zones[0]
  cidr_block        = var.private_subnet_cidrs[0]
  tags = {
    Name = "test-private_subnet1"
  }
}

resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = var.availability_zones[1]
  cidr_block        = var.private_subnet_cidrs[1]
  tags = {
    Name = "test-private_subnet2"
  }
}

#####################################################
#Internet Gateway, NAT Gateway and EIP for NAT Gateway
######################################################
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "test-igw"
  }
}

resource "aws_eip" "nat_eip" {
  # depends_on = [aws_internet_gateway.internet_gateway]
  domain = "vpc"
  tags = {
    Name = "test-eip"
  }
}


resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_1.id
}
###############################################################
##  route tables for subnets and associate them
###############################################################

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "test_public_route_table"
  }
}

resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }
  tags = {
    Name = "test_private_route_table"
  }
}

resource "aws_route_table_association" "private_1" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_2" {
  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.private.id
}