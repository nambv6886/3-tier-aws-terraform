variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "vpc" {
  type        = any
  description = "VPC configuration including ID and subnets"
}

variable "sg" {
  type        = any
  description = "Security group configuration including IDs for web and database"
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
