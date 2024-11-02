resource "aws_internet_gateway" "vpc-igw" {

  vpc_id = aws_vpc.multi-tier-vpc.id

  tags = {
    Name = "vpc-igw"
  }
}

# public-web subnet gets to be accessed via the internet getway
resource "aws_route_table" "public-web-rt" {
    count = length(var.availability_zones)
  vpc_id = aws_vpc.multi-tier-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc-igw.id
  }
}

# associating the public route table with public subnets
resource "aws_route_table_association" "public-web-rt-ass" {
  count          = length(var.availability_zones)
  subnet_id      = aws_subnet.pub-web-sn[count.index].id
  route_table_id = aws_route_table.public-web-rt.id
}


# Elastic IP for nat gateway

resource "aws_eip" "nat_eip" {
    count = length(var.availability_zones)
  domain = "multi-tier-vpc"
}

#creating the nat gateway on the public ip
resource "aws_nat_gateway" "ngw" {
    count = length(var.availability_zones)
  allocation_id = aws_eip.nat_eip.id
  subnet_id = aws_subnet.pub-web-sn[count.index].id
}

# creating a private routing table

resource "aws_route_table" "private_rt" {
  count = length(var.availability_zones)
  vpc_id = aws_vpc.multi-tier-vpc.id

  route{
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw[count.index].id
  }
}

# associating the private route
resource "aws_route_table_association" "private-app-rt-assoc" {
  count = length(var.availability_zones)
  subnet_id = aws_subnet.private-app-sn[count.index].id
  route_table_id = aws_route_table.private_rt.id
}

resource "aws_route_table_association" "private-db-rt-assoc" {
  count = length(var.availability_zones)
  subnet_id = aws_subnet.private-db-sn[count.index].id
  route_table_id = aws_route_table.private_rt.id
}

