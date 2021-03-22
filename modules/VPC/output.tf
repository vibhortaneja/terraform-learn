output "subnets-id-private-eks-list" {
  value = matchkeys(values(aws_subnet.eks_private)[*].id, values(aws_subnet.eks_private)[*].tags["subnet_type"], ["eks-private"])
}
