variable "vpc_cidr" {
  description = "CIDR for VPC"
  type        = string
}

variable "subnets_cidr_private" {
  description = "Define private subnets including name, cidr, az and tagging"
  type        = map(object({ name = string, cidr = string, az = string, tags = map(string) }))
}

variable "subnets_cidr_public" {
  description = "Define public subnets including name, cidr, az and tagging"
  type        = map(object({ name = string, cidr = string, az = string, tags = map(string) }))
}
