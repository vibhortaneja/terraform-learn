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

module "KMS" {
  source = "./modules/KMS"
}

module "EFS" {
  source = "./modules/EFS"

  vpc_id               = module.VPC.vpc_id
  private_subnets_cidr = module.VPC.private_subnets_cidr
  kms_arn              = module.KMS.kms_arn
}

module "ECS" {
  source = "./modules/ECS"

  vpc_id                  = module.VPC.vpc_id
  private_subnets_cidr    = module.VPC.private_subnets_cidr
  public_subnets_cidr     = module.VPC.public_subnets_cidr
  rds_endpoint            = module.RDS.rds_endpoint
  rds_user                = module.RDS.db_username
  rds_password            = module.RDS.ssm_password_arn
  rds_dbname              = module.RDS.db_name
  aws_region              = var.aws_region
  efs_id                  = module.EFS.efs_id
  efs_access_point_theme  = module.EFS.efs_access_point_theme
  efs_access_point_plugin = module.EFS.efs_access_point_plugin
  kms_arn                 = module.KMS.kms_arn
}
