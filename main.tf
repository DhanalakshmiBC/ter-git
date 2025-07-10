provider "aws" {
  region= "us-east-1"
}

resource "aws_instance" "example_server1" {
    ami = "ami-022bbd2ccaf21691f"
    instance_type = "t2.micro"
    tags = {
        Name = "ExampleServer1"
    }
}