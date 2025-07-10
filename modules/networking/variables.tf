variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "environment" {
  description = "The environment for the deployment (e.g., dev, staging, prod)"
  type        = string
}

variable "vpc_cidr_block" {
  type        = string
  description = "The CIDR block for the VPC"
}

variable "private_subnets" {
  type        = list(string)
  description = "List of CIDR blocks for private subnets"
}

variable "public_subnets" {
  type        = list(string)
  description = "List of CIDR blocks for public subnets"
}

variable "database_subnets" {
  type        = list(string)
  description = "List of CIDR blocks for database subnets"
}
