module "VPC" {
  source = "./modules/VPC"

  vpc_cidr       = var.vpc_cidr
  subnets_cidr   = var.subnets_cidr
  azs            = var.azs

}
