
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
