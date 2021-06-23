output "rds_cluster_id" {
  description = "RDS cluster Id"
  value       = aws_rds_cluster.test_wordpress.id
}

output "rds_cluster_arn" {
  description = "RDS cluster Id"
  value       = aws_rds_cluster.test_wordpress.arn
}

output "rds_sg_id" {
  description = "RDS cluster Id"
  value       = aws_security_group.rds_sg.id
}

output "ssm_username_arn" {
  description = "SSM ARN for username"
  value       = aws_ssm_parameter.rds_username_secret.arn
}

output "ssm_password_arn" {
  description = "SSM ARN for pwd"
  value       = aws_ssm_parameter.rds_random_password_secret.arn
}

output "rds_endpoint" {
  description = "rds_endpoint"
  value       = aws_rds_cluster.test_wordpress.endpoint
}
