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

resource "aws_subnet" "public_subnet_2" {
   vpc_id = aws_vpc.vpc_example.id
   count = length(var.private_subnets)
   cidr_block = element(var.private_subnets, count.index)
   availability_zone = element(var.aws_zone, count.index)
   tags = {
       Name = "Deepu Private SUbnet ${count.index + 1}"
   }
}