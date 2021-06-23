data "aws_region" "current" {}

data "aws_caller_identity" "current" {}
resource "aws_ecs_cluster" "wordpress" {
  name = "wordpress-cluster"
  tags = {
    Name = "wordpress"
  }
}

resource "aws_cloudwatch_log_group" "wordpress" {
  name = "/ecs/wordpress"
  retention_in_days = 14
  tags = {
    Name = "wordpress"
  }
}

resource "aws_ecs_task_definition" "wordpress" {
  family = "wordpress-task-defination"
  container_definitions = templatefile(
    "${path.module}/template/wordpress.tpl",
    {
      ecs_service_container_name = "wordpress"
      wordpress_db_host          = var.rds_endpoint
      wordpress_db_user          = var.rds_user
      wordpress_db_name          = var.rds_dbname
      aws_region                 = var.aws_region
      aws_logs_group             = aws_cloudwatch_log_group.wordpress.name
      aws_account_id             = data.aws_caller_identity.current.account_id
      secret_name                = var.rds_password
      cloudwatch_log_group       = aws_cloudwatch_log_group.wordpress.name
    }
  )
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "1024"
  memory                   = "2048"
  execution_role_arn       = aws_iam_role.ecs_task_role.arn
  volume {
    name = "efs-themes"
    efs_volume_configuration {
      file_system_id     = var.efs_id
      root_directory     = "/"
      transit_encryption = "ENABLED"
      authorization_config {
        access_point_id = var.efs_access_point_theme
      }
    }
  }
  volume {
    name = "efs-plugins"
    efs_volume_configuration {
      file_system_id     = var.efs_id
      root_directory     = "/"
      transit_encryption = "ENABLED"
      authorization_config {
        access_point_id = var.efs_access_point_plugin
      }
    }
  }
  tags = {
    Name = "wordpress"
  }
}

resource "aws_ecs_service" "wordpress" {
  name             = "wordpress"
  cluster          = aws_ecs_cluster.wordpress.arn
  task_definition  = aws_ecs_task_definition.wordpress.arn
  desired_count    = 2
  launch_type      = "FARGATE"
  platform_version = "1.4.0"
  propagate_tags   = "SERVICE"
  network_configuration {
    subnets          = var.private_subnets_cidr
    security_groups  = [aws_security_group.ecs_tasks.id]
    assign_public_ip = var.ecs_service_assign_public_ip
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.wordpress_http.arn
    container_name   = "wordpress"
    container_port   = "80"
  }
  tags = {
  Name = "wordpress"
}
}

resource "aws_lb" "wordpress" {
  name               = "wordpress_lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb-sg.id]
  subnets            = var.public_subnets_cidr
  tags = {
    Name = "wordpress"
  }
}

resource "aws_lb_listener" "wordpress_http" {
  load_balancer_arn = aws_lb.wordpress.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wordpress_http.arn
  }
}

resource "aws_lb_listener" "wordpress_https" {
  count             = var.lb_listener_enable_ssl ? 1 : 0
  certificate_arn   = var.lb_listener_certificate_arn
  load_balancer_arn = aws_lb.wordpress.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = var.lb_listener_ssl_policy
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.wordpress_http.arn
  }
}

resource "aws_lb_target_group" "wordpress_http" {
  name        = var.lb_target_group_http
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = var.vpc_id
  health_check {
    matcher = "200-499"
  }
  stickiness {
    type            = "lb_cookie"
    cookie_duration = 86400
    enabled         = true
  }
  tags = {
    Name = "wordpress"
  }
}
