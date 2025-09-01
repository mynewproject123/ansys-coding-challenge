provider "aws" {
  region = var.aws_region
}

# Create VPC
resource "aws_vpc" "vpc_ansys" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "vpc_ansys"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_ansys.id
  tags = {
    Name = "ansys-igw"
  }
}

# Elastic IP for the NAT Gateway
resource "aws_eip" "nat_gateway_eip" {
  domain = "vpc"
  tags = {
    Name = "nat-gateway-eip"
  }
}

# NAT Gateway in the Public Subnet
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_gateway_eip.id
  subnet_id     = aws_subnet.public_subnet1.id  # Or use public_subnet2, based on your preference
  tags = {
    Name = "nat-gateway"
  }
}


# Public Subnets
resource "aws_subnet" "public_subnet1" {
  vpc_id                  = aws_vpc.vpc_ansys.id
  cidr_block              = var.public_subnet_cidrs[0]
  availability_zone       = var.availability_zones[0]
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet1"
  }
}

resource "aws_subnet" "public_subnet2" {
  vpc_id                  = aws_vpc.vpc_ansys.id
  cidr_block              = var.public_subnet_cidrs[1]
  availability_zone       = var.availability_zones[1]
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet2"
  }
}

resource "aws_subnet" "public_subnet3" {
  vpc_id                  = aws_vpc.vpc_ansys.id
  cidr_block              = var.public_subnet_cidrs[2]
  availability_zone       = var.availability_zones[2]
  map_public_ip_on_launch = true
  tags = {
    Name = "public-subnet3"
  }
}

# Private Subnets
resource "aws_subnet" "private_subnet1" {
  vpc_id            = aws_vpc.vpc_ansys.id
  cidr_block        = var.private_subnet_cidrs[0]
  availability_zone = var.availability_zones[0]
  tags = {
    Name = "private-subnet1"
  }
}

resource "aws_subnet" "private_subnet2" {
  vpc_id            = aws_vpc.vpc_ansys.id
  cidr_block        = var.private_subnet_cidrs[1]
  availability_zone = var.availability_zones[1]
  tags = {
    Name = "private-subnet2"
  }
}

resource "aws_subnet" "private_subnet3" {
  vpc_id            = aws_vpc.vpc_ansys.id
  cidr_block        = var.private_subnet_cidrs[2]
  availability_zone = var.availability_zones[2]
  tags = {
    Name = "private-subnet3"
  }
}


# Public Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc_ansys.id
  tags = {
    Name = "public-route-table"
  }
}

# Public Route (Internet Gateway)
resource "aws_route" "public_internet_access" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# Associate Public Subnets with Public Route Table
resource "aws_route_table_association" "public_assoc1" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_assoc2" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_assoc3" {
  subnet_id      = aws_subnet.public_subnet3.id
  route_table_id = aws_route_table.public_rt.id
}

# Private Route Table (No Internet Access)
resource "aws_route_table" "private_rt1" {
  vpc_id = aws_vpc.vpc_ansys.id
  tags = {
    Name = "private-route-table1"
  }
}

# Private Route Table (No Internet Access)
resource "aws_route_table" "private_rt2" {
  vpc_id = aws_vpc.vpc_ansys.id
  tags = {
    Name = "private-route-table2"
  }
}

# Private Route Table (No Internet Access)
resource "aws_route_table" "private_rt3" {
  vpc_id = aws_vpc.vpc_ansys.id
  tags = {
    Name = "private-route-table3"
  }
}

# Associate Private Subnets with Private Route Table
resource "aws_route_table_association" "private_assoc1" {
  subnet_id      = aws_subnet.private_subnet1.id
  route_table_id = aws_route_table.private_rt1.id
}

resource "aws_route_table_association" "private_assoc2" {
  subnet_id      = aws_subnet.private_subnet2.id
  route_table_id = aws_route_table.private_rt2.id
}

resource "aws_route_table_association" "private_assoc3" {
  subnet_id      = aws_subnet.private_subnet3.id
  route_table_id = aws_route_table.private_rt3.id
}


# Route for Private Subnets to Access the Internet via NAT Gateway
resource "aws_route" "private_nat_gateway_route1" {
  route_table_id         = aws_route_table.private_rt1.id  # Private route table
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
}

# Route for Private Subnets to Access the Internet via NAT Gateway
resource "aws_route" "private_nat_gateway_route2" {
  route_table_id         = aws_route_table.private_rt2.id  # Private route table
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
}

# Route for Private Subnets to Access the Internet via NAT Gateway
resource "aws_route" "private_nat_gateway_route3" {
  route_table_id         = aws_route_table.private_rt3.id  # Private route table
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
}
