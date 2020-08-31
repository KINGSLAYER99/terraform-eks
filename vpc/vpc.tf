# child module takes provider of parent module
/*
AWS VPC resource  to create VPC with the cidr block provided
to address dns queries from the instances in VPC, dns_support is enabled
Hostnames for instances are enabled
*/
resource "aws_vpc" "vpc" {
  cidr_block = var.cidr_vpc
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "MyVPC"
    Environment = var.environment_tag
  }
}

# internet Gateway is used to enable connection to internet
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "Internet Gateway"
    Environment = var.environment_tag
  }
}

# Creation of Public Subnets
resource "aws_subnet" "subnet_publicA" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.cidr_Public_subnetA
  map_public_ip_on_launch = "true"
  availability_zone = var.availability_zoneA
  tags = {
    Name = "Public Subnet A"
    Environment = var.environment_tag
  }
}
resource "aws_subnet" "subnet_publicB" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.cidr_Public_subnetB
  map_public_ip_on_launch = "true"
  availability_zone = var.availability_zoneB
  tags = {
    Name = "Public Subnet B"
    Environment = var.environment_tag
  }
}
resource "aws_subnet" "subnet_publicC" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.cidr_Public_subnetC
  map_public_ip_on_launch = "true"
  availability_zone = var.availability_zoneC
  tags = {
    Name = "Public Subnet C"
    Environment = var.environment_tag
  }
}

# Creation of Private Subnets
resource "aws_subnet" "subnet_privateA" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.cidr_Private_subnetA
  availability_zone = var.availability_zoneA
  tags = {
    Name = "Private Subnet A"
    Environment = var.environment_tag
  }
}
resource "aws_subnet" "subnet_privateB" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.cidr_Private_subnetB
  availability_zone = var.availability_zoneB
  tags = {
    Name = "Private Subnet B"
    Environment = var.environment_tag
  }
}
resource "aws_subnet" "subnet_privateC" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = var.cidr_Private_subnetC
  availability_zone = var.availability_zoneC
  tags = {
    Name = "Private Subnet C"
    Environment = var.environment_tag
  }
}

# Creation of Elastic IPs for individual NAT
resource "aws_eip" "natA" {
  vpc = true
}
resource "aws_eip" "natB" {
  vpc = true
}
resource "aws_eip" "natC" {
  vpc = true
}

# Creation of NAT gateways for instances in private subnets to be able to connect to internet
resource "aws_nat_gateway" "ngwA" {
  allocation_id = aws_eip.natA.id
  subnet_id     = aws_subnet.subnet_publicA.id
  depends_on = [aws_internet_gateway.igw]
  tags = {
    Name = "NAT A"
    Environment = var.environment_tag
  }
}
resource "aws_nat_gateway" "ngwB" {
  allocation_id = aws_eip.natB.id
  subnet_id     = aws_subnet.subnet_publicB.id
  depends_on = [aws_internet_gateway.igw]
  tags = {
    Name = "NAT B"
    Environment = var.environment_tag
  }
}
resource "aws_nat_gateway" "ngwC" {
  allocation_id = aws_eip.natC.id
  subnet_id     = aws_subnet.subnet_publicC.id
  depends_on = [aws_internet_gateway.igw]
  tags = {
    Name = "NAT C"
    Environment = var.environment_tag
  }
}

# Creation of Public route table having route to IGW
resource "aws_route_table" "rtb_public" {
  vpc_id = aws_vpc.vpc.id
route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.igw.id
  }
tags = {
    Name = "Public Route Table Common"
    Environment = var.environment_tag
  }
}
/*resource "aws_route_table" "rtb_publicB" {
  vpc_id = aws_vpc.vpc.id
route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.igw.id
  }
tags = {
    Name = "Public Route Table B"
    Environment = var.environment_tag
  }
}
resource "aws_route_table" "rtb_publicC" {
  vpc_id = aws_vpc.vpc.id
route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.igw.id
  }
tags = {
    Name = "Public Route Table C"
    Environment = var.environment_tag
  }
}*/

# Creation of Private route tables having route to NATs
resource "aws_route_table" "rtb_privateA" {
  vpc_id = aws_vpc.vpc.id
route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_nat_gateway.ngwA.id
  }
tags = {
    Name = "Private Route Table A"
    Environment = var.environment_tag
  }
}
resource "aws_route_table" "rtb_privateB" {
  vpc_id = aws_vpc.vpc.id
route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_nat_gateway.ngwB.id
  }
tags = {
    Name = "Private Route Table B"
    Environment = var.environment_tag
  }
}
resource "aws_route_table" "rtb_privateC" {
  vpc_id = aws_vpc.vpc.id
route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_nat_gateway.ngwC.id
  }
tags = {
    Name = "Private Route Table C"
    Environment = var.environment_tag
  }
}

# Associating subnets to a route table. 1 route table can have multiple subnets associated with it
resource "aws_route_table_association" "rta_subnet_publicA" {
  subnet_id      = aws_subnet.subnet_publicA.id
  route_table_id = aws_route_table.rtb_public.id
}
resource "aws_route_table_association" "rta_subnet_publicB" {
  subnet_id      = aws_subnet.subnet_publicB.id
  route_table_id = aws_route_table.rtb_public.id
}
resource "aws_route_table_association" "rta_subnet_publicC" {
  subnet_id      = aws_subnet.subnet_publicC.id
  route_table_id = aws_route_table.rtb_public.id
}

resource "aws_route_table_association" "rta_subnet_privateA" {
  subnet_id      = aws_subnet.subnet_privateA.id
  route_table_id = aws_route_table.rtb_privateA.id
}
resource "aws_route_table_association" "rta_subnet_privateB" {
  subnet_id      = aws_subnet.subnet_privateB.id
  route_table_id = aws_route_table.rtb_privateB.id
}
resource "aws_route_table_association" "rta_subnet_privateC" {
  subnet_id      = aws_subnet.subnet_privateC.id
  route_table_id = aws_route_table.rtb_privateC.id
}