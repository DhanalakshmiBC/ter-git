variable "public_subnets" {
    type = list(string)
    description = "cidr blocks for public subnets"
    default = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]
}

variable "private_subnets" {
    type = list(string)
    description = "cidr blocks for private subnets"
    default = ["10.0.5.0/24","10.0.6.0/24","10.0.7.0/24"]
}

variable "aws_zone" {
    type = list(string)
    description = "Aws zones to deploy resources"
    default = ["us-east-1a","us-east-1b","us-east-1c"]
}