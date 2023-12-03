variable "vpc_id" {
  description = "Main VPC id"
}

variable "azs" {
  description = "Availability zones"
}

variable "public_subnet_ids" {
  description = "Public Subnet ids"
}

variable "ec2_type" {
  description = "Main EC2 instance type"
}

variable "ec2_nic_id" {
  description = "Network interface for main EC2 instance"
}
