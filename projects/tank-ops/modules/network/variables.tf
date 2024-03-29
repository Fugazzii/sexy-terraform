variable "cidr_block" {
  description = "CIDR block of the network"
}

variable "azs" {
  description = "Availability zones"
}

variable "public_subnets" {
  description = "CIDR blocks of public subnets"
}

variable "private_subnets" {
  description = "CIDR blocks of private subnets"
}
