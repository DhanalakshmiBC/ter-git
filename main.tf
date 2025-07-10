provider "aws" {
  region= "us-west-2"
}

resource "aws_instance" "example_server1" {
    ami = "ami-022bbd2ccaf21691f"
    instance_type = "t2.micro"
    tags = {
        Name = "ExampleServer1"
    }
}