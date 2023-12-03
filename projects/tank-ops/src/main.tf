provider "aws" {
  region = var.region
}

module "networks" {
  source          = "../modules/network"
  cidr_block      = var.cidr_block
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
  azs             = var.azs
}

module "vm" {
  source            = "../modules/vm"
  ec2_type          = var.ec2_type
  azs               = var.azs
  vpc_id            = module.networks.vpc_id
  public_subnet_ids = module.networks.public_subnet_ids
  ec2_nic_id        = module.networks.ec2_nic_id
}
