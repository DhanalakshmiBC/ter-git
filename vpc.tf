


resource "aws_vpc" "vpc_example" {
    cidr_block = "10.0.0.0/16"

    tags = {
       Name = "ExampleVPC"
    }

}