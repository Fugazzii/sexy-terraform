variable "region" {
  description = "Region of AWS"
  type        = string
}

variable "cidr_block" {
  description = "Main CIDR block for network"
  type        = string
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
}

variable "public_subnets" {
  description = "List of public subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnets"
  type        = list(string)
}

variable "ec2_type" {
  description = "Type for main EC2 instance"
  type        = string
}
