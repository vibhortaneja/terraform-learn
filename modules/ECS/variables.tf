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

variable "kms_arn" {
  description = "kms_arn"
  type        = string
}

variable "lb_listener_enable_ssl" {
  description = "Enable the SSL listener, if this is set the lb_listener_certificate_arn must also be provided"
  type        = bool
  default     = false
}

variable "lb_listener_certificate_arn" {
  description = "The ACM certificate ARN to use on the HTTPS listener"
  type        = string
  default     = ""
}

variable "lb_listener_ssl_policy" {
  description = "The SSL policy to apply to the HTTPS listener"
  type        = string
  default     = "ELBSecurityPolicy-FS-1-2-Res-2019-08"
}

variable "lb_target_group_http" {
  description = "Name of the HTTP target group"
  type        = string
  default     = "wordpress-http"
}

variable "lb_target_group_https" {
  description = "Name of the HTTPS target group"
  type        = string
  default     = "wordpress-https"
}

variable "ecs_service_assign_public_ip" {
  description = "Whether to assign a public IP to the task ENIs"
  type        = bool
  default     = false
}
