# provider "aws" {
#   region= "us-east-1"
# }

# resource "aws_instance" "example_server1" {
#     ami = "ami-05ffe3c48a9991133"
#     instance_type = "t2.micro"
#     subnet_id              = aws_subnet.public_subnet_1.id
#     key_name               = "my-key-pair"
#     vpc_security_group_ids = [aws_security_group.terrafrom_sg.id]
#     tags = {
#         Name = "Terraform_Instance"
#   }
# }
