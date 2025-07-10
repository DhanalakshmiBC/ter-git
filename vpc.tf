resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"
  tags = {
    Name = "My_VPC"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = var.ZONE1
  tags = {
    Name = "Public_Subnet_1"
  }
}

resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "IGW"
  }
}

resource "aws_route_table" "public_RT" {
  vpc_id = aws_vpc.my_vpc.id


  route = {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }
  tags = {
    Name = "Pulic_RT"
  }
}

resource "aws_route_table_association" "public_subnet_1a" {
  subnet_id = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_RT.id
}

resource "aws_security_group" "terrafrom_sg" {
  name        = "allow_ssh"
  description = "sg for to allow ssh"
  vpc_id      = aws_vpc.my_vpc.id

  tags = {
    Name = "Terraform_project_sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.terrafrom_sg.id
  cidr_ipv4         = ["0.0.0.0/0"]
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}


resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.terrafrom_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}