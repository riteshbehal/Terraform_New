# Create AWS VPC
resource "aws_vpc" "levelupvpc" {
  cidr_block           = "10.0.0.0/16"
  instance_tenancy     = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "levelupvpc"
  }
}

# Public Subnet 1
resource "aws_subnet" "levelupvpc_public_1" {
  vpc_id                  = aws_vpc.levelupvpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"

  tags = {
    Name = "levelupvpc-public-1"
  }
}

# Public Subnet 2
resource "aws_subnet" "levelupvpc_public_2" {
  vpc_id                  = aws_vpc.levelupvpc.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1b"

  tags = {
    Name = "levelupvpc-public-2"
  }
}

# Public Subnet 3
resource "aws_subnet" "levelupvpc_public_3" {
  vpc_id                  = aws_vpc.levelupvpc.id
  cidr_block              = "10.0.3.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1c"

  tags = {
    Name = "levelupvpc-public-3"
  }
}

# Private Subnet 1
resource "aws_subnet" "levelupvpc_private_1" {
  vpc_id                  = aws_vpc.levelupvpc.id
  cidr_block              = "10.0.4.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1a"

  tags = {
    Name = "levelupvpc-private-1"
  }
}

# Private Subnet 2
resource "aws_subnet" "levelupvpc_private_2" {
  vpc_id                  = aws_vpc.levelupvpc.id
  cidr_block              = "10.0.5.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1b"

  tags = {
    Name = "levelupvpc-private-2"
  }
}

# Private Subnet 3
resource "aws_subnet" "levelupvpc_private_3" {
  vpc_id                  = aws_vpc.levelupvpc.id
  cidr_block              = "10.0.6.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1c"

  tags = {
    Name = "levelupvpc-private-3"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "levelup_gw" {
  vpc_id = aws_vpc.levelupvpc.id

  tags = {
    Name = "levelup-gw"
  }
}

# Public Route Table
resource "aws_route_table" "levelup_public" {
  vpc_id = aws_vpc.levelupvpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.levelup_gw.id
  }

  tags = {
    Name = "levelup-public"
  }
}

# Route Table Association - Public Subnet 1
resource "aws_route_table_association" "public_1_assoc" {
  subnet_id      = aws_subnet.levelupvpc_public_1.id
  route_table_id = aws_route_table.levelup_public.id
}

# Route Table Association - Public Subnet 2
resource "aws_route_table_association" "public_2_assoc" {
  subnet_id      = aws_subnet.levelupvpc_public_2.id
  route_table_id = aws_route_table.levelup_public.id
}

# Route Table Association - Public Subnet 3
resource "aws_route_table_association" "public_3_assoc" {
  subnet_id      = aws_subnet.levelupvpc_public_3.id
  route_table_id = aws_route_table.levelup_public.id
}