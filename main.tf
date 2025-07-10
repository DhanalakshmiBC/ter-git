provider "aws" {
  region = "us-west-1"
}

resource "aws_vpc" "own_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "own-vpc"
  }
  
}

resource "aws_subnet" "main_subnet" {
  vpc_id = aws_vpc.own_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-west-1a"
  tags = {
    Name = "main-subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.own_vpc.id
  tags = {
    Name = "own-igw"
  }
}

resource "aws_route_table" "main_route" {
  vpc_id = aws_vpc.own_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "own-route-table"
  }
}

resource "aws_route_table_association" "main_association" {
  subnet_id = aws_subnet.main_subnet.id
  route_table_id = aws_route_table.main_route.id
}

resource "aws_security_group" "own_sg" {
  name = "allow-ssh"
  description = "Allow SSH inbound traffic"
  vpc_id = aws_vpc.own_vpc.id
  
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"] 
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  tags = {
    Name = "allow-ssh"
  }


}

resource "aws_instance" "own_inst" {
  ami = "ami-061ad72bc140532fd"
  security_groups = [aws_security_group.own_sg.id]
  subnet_id = aws_subnet.main_subnet.id
  instance_type = "t2.micro"
  associate_public_ip_address = true
  tags = {
    Name = "own-instance"
  }  
}
