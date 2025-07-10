terraform {
  backend "s3" {
    bucket         = "deepika-bucket-aaal"
    key            = "terraform/state"
    region         = "us-west-2"
    encrypt = true
    
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}