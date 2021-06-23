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

variable "rds_endpoint" {
  description = "endpoint of RDS"
  type        = string
}

variable "rds_user" {
  description = "RDS username"
  type        = string
}

variable "rds_password" {
  description = "RDS password"
  type        = string
}

variable "aws_region" {
  description = "AWS Region"
  type        = string
}

variable "rds_dbname" {
  description = "RDS db name"
  type        = string
}

variable "efs_id" {
  description = "efs_id"
  type        = string
}

variable "efs_access_point_theme" {
  description = "efs_access_point_theme"
  type        = string
}

variable "efs_access_point_plugin" {
  description = "efs_access_point_plugin"
  type        = string
}
