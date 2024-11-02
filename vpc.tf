resource "aws_vpc" "multi-tier-vpc" {
  cidr_block = var.vpc_cidr_block
  instance_tenancy = "dfault"
  tags = {
    Name = "multi-tier-vpc"
  }

}