resource "aws_vpc" "vpc_demo" {
  cidr_block           = var.cidr
 # instance_tenancy     = var.instance_tenancy
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
#   enable_classiclink   = var.enable_classiclink

  tags = {
    Name = var.tags
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_demo.id

  tags = {
    Name = "internet-gateway-demo"
  }
}

resource "aws_subnet" "public-1" {
  availability_zone       = "us-east-1a"
  vpc_id                  = aws_vpc.vpc_demo.id
  map_public_ip_on_launch = true
  cidr_block              = "10.0.1.0/24"

  tags = {
    Name = "public-1-demo"
  }
}

resource "aws_route_table" "route-public" {
  vpc_id = aws_vpc.vpc_demo.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table-demo"
  }
}

resource "aws_route_table_association" "pub-1" {
  subnet_id      = aws_subnet.public-1.id
  route_table_id = aws_route_table.route-public.id
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_SSH"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_vpc.vpc_demo.id

  ingress {
    # SSH Port 22 allowed from any IP
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {  #inbound rule
      # SSH Port 80 allowed from any IP
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    

  egress {      # outbound rule
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "subnet_id"{
    value = aws_subnet.public-1.id
}

output "security_group" {
  value = aws_security_group.allow_ssh.id
}
