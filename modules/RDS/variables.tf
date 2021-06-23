variable "ssm_name_rds_pwd" {
  description = "ssm name for storing rds password"
  type        = string
}

variable "ssm_name_rds_user" {
  description = "ssm name for storing rds username"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnets_cidr" {
  description = "List of private subnets CIDR"
  type        = list(string)
}
