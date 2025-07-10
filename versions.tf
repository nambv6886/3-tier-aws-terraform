terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  backend "s3" {
    bucket         = var.backend_s3_bucket
    key            = var.backend_s3_key
    region         = var.backend_s3_region
    dynamodb_table = var.backend_dynamodb_table
  }
}

provider "aws" {
  region = var.aws_region
}
