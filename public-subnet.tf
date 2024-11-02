resource "aws_subnet" "pub-web-sn" {
    count = length(var.availability_zones)
    vpc_id = aws_vpc.multi-tier-vpc.id
    availability_zone = [var.availability_zones[count.index]]
    cidr_block = [var.public_web_cidr[count.index]]
    tags = {
      Name = "pub-web-subnet-${count.index + 1}"
    }
}