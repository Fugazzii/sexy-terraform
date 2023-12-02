provider "aws" {
  region = var.region
}

module "networks" {
  source          = "../modules/network"
  cidr_block      = var.cidr_block
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
}
