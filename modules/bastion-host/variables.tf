variable "vpc" {
  type        = any
  description = "VPC configuration including ID and subnets"
}

variable "sg" {
  type        = any
  description = "Security group configuration including IDs for web and database"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}
variable "bastion_host_instance_type" {
  description = "Instance type for the bastion host"
  type        = string
  default     = "t2.micro"
}

variable "bastion_host_instance_key_name" {
  description = "SSH key pair name for accessing the bastion host "
  type        = string
}
