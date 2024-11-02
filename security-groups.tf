# Security Group for Public EC2 instance

resource "aws_security_group" "pub-sg" {
    name = "public-web-sg"
    vpc_id = aws_vpc.multi-tier-vpc.id
  tags = {
    Name = "public-web-sg"
  }
    # allow SSH connection
  ingress{
    description = "Allow SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"

  }

#   allow Internet connection on port 80. HTTP connection

    ingress{
        description = "Allow HTTP"
        from_port = 80
        to_port = 80
        protocol = "tcp"
    }
    # allow all outbound traffic
    egress{
        from_port = 0
        to_port = 0
        protocol = "-1"
    }
}

resource "aws_security_group" "private-sg" {
  
}