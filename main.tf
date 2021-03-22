module "VPC" {
  source = "./modules/VPC"

  vpc_cidr = var.vpc_cidr
  subnets_cidr_public = var.subnets_cidr_public
  subnets_cidr_private = var.subnets_cidr_private
}

module "EKS" {
  source = "./modules/EKS"

  //public_subnets = var.subnets_cidr_public
  private_subnets = module.VPC.subnets-id-private-eks-list
  eks_node_group_instance_types = var.eks_node_group_instance_types
  fargate_namespace = var.fargate_namespace
}
