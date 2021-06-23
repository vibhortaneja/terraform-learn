resource "random_string" "random_password" {
  length  = 25
  special = false
}

resource "aws_ssm_parameter" "rds_random_password_secret" {
  name        = var.ssm_name_rds_pwd
  description = "RDS Password"
  type        = "SecureString"
  value       = random_string.random_password.result
}

resource "aws_ssm_parameter" "rds_username_secret" {
  name        = var.ssm_name_rds_user
  description = "RDS username"
  type        = "SecureString"
  value       = "admin"
}

#RDS Subnet
resource "aws_db_subnet_group" "rds_subnet" {
  name        = "rds-subnet"
  description = "RDS subnet group"
  subnet_ids  = var.private_subnets_cidr
}

resource "aws_rds_cluster" "test_wordpress" {
  cluster_identifier      = "aurora-cluster-test"
  engine                  = "aurora-mysql"
  engine_version          = "5.7.mysql_aurora.2.03.2"
  availability_zones      = ["eu-west-1a", "eu-west-1b"]
  database_name           = "wordpressdb"
  master_username         = aws_ssm_parameter.rds_username_secret.value
  master_password         = aws_ssm_parameter.rds_random_password_secret.value
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet.name
  backup_retention_period = 5
  preferred_backup_window = "07:00-09:00"
}

resource "aws_rds_cluster_instance" "test_wordpress_instances" {
  count              = 2
  identifier         = "aurora-cluster-test-${count.index}"
  cluster_identifier = aws_rds_cluster.test_wordpress.id
  instance_class     = "db.r4.large"
  engine             = aws_rds_cluster.test_wordpress.engine
  engine_version     = aws_rds_cluster.test_wordpress.engine_version
}
