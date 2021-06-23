output "vpc_id" {
  value       = aws_vpc.test_vpc.id
  description = "VPC Id"
}

output "vpc_security_group_id" {
  value       = aws_security_group.vpc_sg.id
  description = "Vpc security group id"
}

output "private_subnets_cidr" {
  value       = values(aws_subnet.subnet_private)[*].id
  description = "Vpc private subnets CIDR"
}

output "public_subnets_cidr" {
  value       = values(aws_subnet.subnet_public)[*].id
  description = "Vpc public subnets CIDR"
}
