module "VPC" {
  source = "./modules/VPC"

  vpc_cidr             = var.vpc_cidr
  subnets_cidr_public  = var.subnets_cidr_public
  subnets_cidr_private = var.subnets_cidr_private
}

module "RDS" {
  source = "./modules/RDS"

  ssm_name_rds_pwd     = var.ssm_name_rds_pwd
  ssm_name_rds_user    = var.ssm_name_rds_user
  vpc_id               = module.VPC.vpc_id
  private_subnets_cidr = module.VPC.private_subnets_cidr
}
