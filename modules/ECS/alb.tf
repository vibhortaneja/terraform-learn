resource "aws_alb" "wordpressalb" {
  name                       = "wordpressalb"
  internal                   = false
  subnets                    = var.public_subnets_cidr
  security_groups            = [aws_security_group.alb-sg.id]
  enable_deletion_protection = true
  tags = {
    Environment = "production"
  }
}
resource "aws_alb_target_group" "ecs-target-group" {
  name        = "ecs-target-group"
  port        = "80"
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold   = "7"
    unhealthy_threshold = "7"
    interval            = "120"
    matcher             = "200"
    path                = "/"
    protocol            = "HTTP"
    timeout             = "5"
  }
  tags = {
    Name = "ecs-target-group"
  }
}
resource "aws_alb_listener" "alb-listener" {
  load_balancer_arn = aws_alb.wordpressalb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_alb_target_group.ecs-target-group.arn
    type             = "forward"
  }
}
