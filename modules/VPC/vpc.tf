# VPC
resource "aws_vpc" "test_vpc" {
  cidr_block       = var.vpc_cidr
  tags = {
    Name = "VibhorVPC"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "test_igw" {
  vpc_id = aws_vpc.test_vpc.id
  tags = {
    Name = "test_internet_gateway"
  }
}

resource "aws_subnet" "eks_public" {
  for_each = var.subnets_cidr_public

  vpc_id = aws_vpc.test_vpc.id
  cidr_block = each.value.cidr
  availability_zone = each.value.az
  tags = each.value.tags
}

// Create private subnets dedicated to all AWS resources, excluding EKS
resource "aws_subnet" "eks_private" {
  for_each = var.subnets_cidr_private

  vpc_id = aws_vpc.test_vpc.id
  cidr_block = each.value.cidr
  availability_zone = each.value.az
  tags = each.value.tags
}

# Route table public: attach Internet Gateway
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.test_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test_igw.id
  }
  tags = {
    Name = "publicRouteTable"
  }
}

# Route table private: attach nat Gateway
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.test_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test_igw.id
  }
  tags = {
    Name = "privateRouteTable"
  }
}

# Route table association with public subnets
resource "aws_route_table_association" "rt_association-public" {
  for_each       = aws_subnet.eks_public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public_rt.id
}
