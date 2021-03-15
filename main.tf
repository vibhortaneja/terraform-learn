module "CLOUDFRONT" {
  source = "./modules/VPC"

  aws_region     = var.aws_region
  vpc_cidr       = var.vpc_cidr
  subnets_cidr   = var.subnets_cidr
  azs            = var.azs

}
