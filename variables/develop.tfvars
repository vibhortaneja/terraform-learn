aws_region = "eu-west-1"
vpc_cidr   = "10.20.0.0/16"

subnets_cidr_public = {
  "public1" = {
    "name" = "public-1a",
    "cidr" = "10.20.1.0/24",
    "az"   = "eu-west-1a",
    "tags" = {
      "subnet_type" = "public-1"
    }
  },
  "public2" = {
    "name" = "public-1b",
    "cidr" = "10.20.2.0/24",
    "az"   = "eu-west-1b",
    "tags" = {
      "subnet_type" = "public-2"
    }
  }
}

subnets_cidr_private = {
  "private1" = {
    "name" = "private-1a",
    "cidr" = "10.20.3.0/24",
    "az"   = "eu-west-1a",
    "tags" = {
      "subnet_type" = "private-1"
    }
  },
  "private2" = {
    "name" = "private-1b",
    "cidr" = "10.20.4.0/24",
    "az"   = "eu-west-1b",
    "tags" = {
      "subnet_type" = "private-2"
    }
  }
}

ssm_name_rds_pwd  = "/wordpress/rds/pwd"
ssm_name_rds_user = "/wordpress/rds/username"

public_alb_domain = "wordpress.com"
site_domain       = "vibhor.wordpress.com"
