provider "aws" {
  region= "us-west-2"
}

resource "aws_instance" "example_server1" {
    ami = "ami-0fe0b46cdde731a2e"
    instance_type = "t2.micro"
    tags = {
        Name = "ExampleServer1"
    }
}