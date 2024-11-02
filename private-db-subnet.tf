resource "aws_subnet" "private-db-sn" {
    count = length(var.availability_zones)
    vpc_id = aws_vpc.multi-tier-vpc.id
    availability_zone = [var.availability_zones[count.index]]
    cidr_block = [var.private_db_cidr[count.index]]
    tags = {
      Name = "private-db-subnet-${count.index + 1}"
    }
}