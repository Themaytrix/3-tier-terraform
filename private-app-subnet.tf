resource "aws_subnet" "private-app-sn" {
    count = length(var.availability_zones)
    vpc_id = aws_vpc.multi-tier-vpc.id
    availability_zone = [var.availability_zones[count.index]]
    cidr_block = [var.private_app_cidr[count.index]]
    tags = {
      Name = "private-app-subnet-${count.index + 1}"
    }
}