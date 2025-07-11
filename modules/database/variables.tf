
variable "project_name" {
  type        = string
  description = "The name of the project"
}

variable "vpc" {
  type        = any
  description = "VPC module output"
}

variable "sg" {
  type        = any
  description = "Security group module output"
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
