//variable "public_subnets" {
//  description = "Public Subnets of VPC"
//  type        = map(object({ name = string, cidr = string, az = string, tags = map(string) }))
//}

variable "private_subnets" {
  description = "Private subnets of VPC"
  type = list(string)
}

variable "eks_node_group_instance_types" {
  description = "Instance type of node group"
}

variable "fargate_namespace" {
  description = "Namespace for fargate"
}
