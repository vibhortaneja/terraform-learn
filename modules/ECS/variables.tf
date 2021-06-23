variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnets_cidr" {
  description = "List of private subnets CIDR"
  type        = list(string)
}

variable "public_subnets_cidr" {
  description = "List of private subnets CIDR"
  type        = list(string)
}
