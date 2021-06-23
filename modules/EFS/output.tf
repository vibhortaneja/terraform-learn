output "efs_id" {
  description = "efs id"
  value       = aws_efs_file_system.wordpress.id
}

output "efs_access_point_theme" {
  description = "efs_access_point_theme"
  value       = aws_efs_access_point.wordpress_themes.id
}

output "efs_access_point_plugin" {
  description = "efs_access_point_plugin"
  value       = aws_efs_access_point.wordpress_plugins.id
}