resource "aws_security_group" "efs_sg" {
  vpc_id      = var.vpc_id
  name        = "efs-sg"
  description = "Allow inbound efs traffic"

  ingress {
    description     = "Allow communication in VPC on NFS port"
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
    self            = true
  }

  tags = {
    Name = "efs-sg"
  }
}
