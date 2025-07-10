terraform {
    backend "s3" {
        bucket = "deepu-store-aa"
        key = "terraform/state"
        region = "us-east-1"
        encrypt = true
    }
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~> 3.0"
        }
    }
}