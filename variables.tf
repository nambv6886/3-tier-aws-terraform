variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "backend_s3_bucket" {
  description = "The S3 bucket for storing Terraform state"
  type        = string
}

variable "backend_s3_key" {
  description = "The S3 key for the Terraform state file"
  type        = string
}

variable "backend_s3_region" {
  description = "The AWS region for the S3 backend"
  type        = string
}

variable "backend_dynamodb_table" {
  description = "The DynamoDB table for state locking"
  type        = string
}
