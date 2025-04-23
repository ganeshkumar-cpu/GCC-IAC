resource "aws_vpc" "this" {
  cidr_block = var.cidr_block
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public_ap_south_1a" {
  vpc_id     = aws_vpc.this.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "gcc-vpc-facial-subnet-public1-ap-south-1a"
  }
}

resource "aws_subnet" "private_ap_south_1a" {
  vpc_id     = aws_vpc.this.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "gcc-vpc-facial-subnet-private1-ap-south-1a"
  }
}

resource "aws_subnet" "public_ap_south_1b" {
  vpc_id     = aws_vpc.this.id
  cidr_block = "10.0.101.0/24"
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "gcc-vpc-facial-subnet-public2-ap-south-1b"
  }
}

resource "aws_subnet" "private_ap_south_1b" {
  vpc_id     = aws_vpc.this.id
  cidr_block = "10.0.102.0/24"
  availability_zone = "ap-south-1b"
  tags = {
    Name = "gcc-vpc-facial-subnet-private2-ap-south-1b"
  }
}

resource "aws_route_table" "public_rtb" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "gcc-vpc-facial-rtb-public"
  }
}

resource "aws_route_table" "private_rtb_ap_south_1a" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "gcc-vpc-facial-rtb-private1-ap-south-1a"
  }
}

resource "aws_route_table" "private_rtb_ap_south_1b" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "gcc-vpc-facial-rtb-private2-ap-south-1b"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "gcc-vpc-facial-igw"
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_ap_south_1a.id
  depends_on    = [aws_internet_gateway.igw]
}

resource "aws_eip" "nat_eip" {
  vpc = true
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public_rtb.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route" "private_route" {
  route_table_id         = aws_route_table.private_rtb_ap_south_1a.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
}

resource "aws_route" "private_route_1b" {
  route_table_id         = aws_route_table.private_rtb_ap_south_1b.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
}

output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnets" {
  value = [aws_subnet.public_ap_south_1a.id, aws_subnet.public_ap_south_1b.id]
}

output "private_subnets" {
  value = [aws_subnet.private_ap_south_1a.id, aws_subnet.private_ap_south_1b.id]
}

output "vpc_cidr" {
  value = aws_vpc.this.cidr_block
}
