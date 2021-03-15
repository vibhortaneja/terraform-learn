variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "subnets_cidr" {
  description = "List of subnets CIDR"
  type        = list(string)
}

variable "azs" {
  description = "List of availability zones"
  type        = list(string)
}
