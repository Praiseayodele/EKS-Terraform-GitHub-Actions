terraform {
  required_version = "~> 1.14.3"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.49.0"
    }
  }
  backend "s3" {
    bucket         = "praise-terraform-state-bucket"
    region         = "us-east-1"
    key            = "eks/terraform.tfstate"
    dynamodb_table = "Lock-Files"
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws-region
}
