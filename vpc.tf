resource "aws_vpc" "vpc_example" {
    cidr_block = "10.0.0.0/16"

    tags = {
       Name = "ExampleVPC"
    }

}

resource "aws_subnet" "public_subnets" {
    count = length(var.public_subnets)
    vpc_id = aws_vpc.vpc_example.id
    cidr_block = element(var.public_subnets, count.index)
    availability_zone = element(var.aws_zone, count.index)
    tags = {
        Name = "Deepu Public SUbnet ${count.index + 1}"
    }

}

resource "aws_subnet" "private_subnets" {
   vpc_id = aws_vpc.vpc_example.id
   count = length(var.private_subnets)
   cidr_block = element(var.private_subnets, count.index)
   availability_zone = element(var.aws_zone, count.index)
   tags = {
       Name = "Deepu Private SUbnet ${count.index + 1}"
   }
}

resource "aws_internet_gateway" "igw_example" {
    vpc_id = aws_vpc.vpc_example.id

    tags = {
        Name = "ExampleIGW"
    }
}

resource "aws_route_table" "first_rt" {
    vpc_id = aws_vpc.vpc_example.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw_example.id
    }

    tags = {
        Name = "ExampleRouteTable"
    }
}

resource "aws_route_table_association" "public_subnet_association" {
    count = length(var.public_subnets)
    subnet_id = element(aws_subnet.public_subnets[*].id, count.index)
    route_table_id = aws_route_table.first_rt.id
}