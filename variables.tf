variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "azs" {
  description = "List of availability zones to use for the VPC"
  type        = list(string)
  default     = ["ap-southeast-1a", "ap-southeast-1b"]
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

variable "ec2_instance_type" {
  description = "EC2 instance type for the web application"
  type        = string
  default     = "t2.micro"
}
variable "ec2_instance_key_name" {
  description = "SSH key pair name for accessing the EC2 instances"
  type        = string
}
variable "ec2_autoscaling_min_size" {
  description = "Minimum number of instances in the Auto Scaling group"
  type        = number
  default     = 1
}
variable "ec2_autoscaling_max_size" {
  description = "Maximum number of instances in the Auto Scaling group"
  type        = number
  default     = 2
}
variable "ec2_autoscaling_desired_capacity" {
  description = "Desired number of instances in the Auto Scaling group"
  type        = number
  default     = 1
}
variable "db_instance_type" {
  description = "Database instance type"
  type        = string
  default     = "db.t2.micro"
}

variable "db_engine" {
  description = "Database engine type"
  type        = string
  default     = "postgres"
}

variable "db_engine_version" {
  description = "Database engine version"
  type        = string
  default     = "10"
}
variable "db_name" {
  description = "Name of the database"
  type        = string
  default     = "mydatabase"
}

variable "db_username" {
  description = "Database username"
  type        = string
  default     = "dbadmin"
}

variable "bastion_host_instance_type" {
  description = "Instance type for the bastion host"
  type        = string
  default     = "t2.micro"
}

variable "bastion_host_instance_key_name" {
  description = "SSH key pair name for accessing the bastion host"
  type        = string
}
