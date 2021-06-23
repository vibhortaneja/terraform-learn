#RDS security group
resource "aws_security_group" "rds_sg" {
  vpc_id      = var.vpc_id
  name        = "rds-sg"
  description = "Allow inbound Mysql traffic"

  ingress {
    description = "Allow communication in VPC on port 3306"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    self        = true
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-sg"
  }
}
