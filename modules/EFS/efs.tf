#EFS
resource "aws_efs_file_system" "wordpress" {
  creation_token = "wordpress"
  encrypted      = true
  kms_key_id     = var.kms_arn
  tags = {
    Name = "File System Wordpress"
  }
}

resource "aws_efs_mount_target" "wordpress" {
  count           = length(var.private_subnets_cidr)
  file_system_id  = aws_efs_file_system.wordpress.id
  subnet_id       = var.private_subnets_cidr[count.index]
  security_groups = [aws_security_group.efs_sg.id]
}

resource "aws_efs_access_point" "wordpress_plugins" {
  file_system_id = aws_efs_file_system.wordpress.id
  posix_user {
    gid = 33
    uid = 33
  }
  root_directory {
    path = "/plugins"
    creation_info {
      owner_gid   = 33
      owner_uid   = 33
      permissions = 755
    }
  }
}

resource "aws_efs_access_point" "wordpress_themes" {
  file_system_id = aws_efs_file_system.wordpress.id
  posix_user {
    gid = 33
    uid = 33
  }
  root_directory {
    path = "/themes"
    creation_info {
      owner_gid   = 33
      owner_uid   = 33
      permissions = 755
    }
  }
}
