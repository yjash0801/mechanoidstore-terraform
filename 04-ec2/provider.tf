terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.57.0"
    }
  }
  
  backend "s3" {
    bucket = "mechanoidstore-remote-state"
    key    = "ec2"
    region = "us-east-1"
    dynamodb_table = "mechanoidstore-locking"
  }
}

provider "aws" {
  region = "us-east-1"
}