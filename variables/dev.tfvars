aws_region = "eu-west-1"
vpc_cidr = "10.20.0.0/16"

subnets_cidr_public =  {
  "public1" = {"name" = "EKS-public-1a", "cidr" = "10.20.1.0/24", "az" = "eu-west-1a", "tags" = {"subnet_type" = "eks-public"}},
  "public2" = {"name" = "EKS-public-1b", "cidr" = "10.20.2.0/24", "az" = "eu-west-1b", "tags" = {"subnet_type" = "eks-public"}}
}

subnets_cidr_private = {
  "private1" = {"name" = "EKS-private-1a", "cidr" = "10.20.3.0/24", "az" =  "eu-west-1a", "tags" = {"subnet_type" = "eks-private" }},
  "private2" = {"name" = "EKS-private-1b", "cidr" = "10.20.4.0/24", "az" =  "eu-west-1b", "tags" = {"subnet_type" = "eks-private" }}
}

fargate_namespace = "default"
eks_node_group_instance_types = "t2.micro"
