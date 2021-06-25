resource "aws_appautoscaling_target" "wordpress-autoscaling-target" {
  service_namespace  = "ecs"
  resource_id        = "service/${aws_ecs_cluster.wordpress-cluster.name}/${aws_ecs_service.wordpress-service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  role_arn           = local.ecs_autoscale_role
  min_capacity       = 1
  max_capacity       = 3
}

# Automatically scale capacity up by one
resource "aws_appautoscaling_policy" "htm-if-asg-policy-up-tenant-org-service" {
  name               = "wordpress-asg-policy-up"
  service_namespace  = aws_appautoscaling_target.wordpress-autoscaling-target.service_namespace
  resource_id        = aws_appautoscaling_target.wordpress-autoscaling-target.resource_id
  scalable_dimension = aws_appautoscaling_target.wordpress-autoscaling-target.scalable_dimension

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Maximum"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = 1
    }
  }

  depends_on = [aws_appautoscaling_target.wordpress-autoscaling-target]
}

# Automatically scale capacity down by one
resource "aws_appautoscaling_policy" "htm-if-asg-policy-down-tenant-org-service" {
  name               = "wordpress-asg-policy-down"
  service_namespace  = "ecs"
  resource_id        = "service/${aws_ecs_cluster.wordpress-cluster.name}/${aws_ecs_service.wordpress-service.name}"
  scalable_dimension = "ecs:service:DesiredCount"

  step_scaling_policy_configuration {
    adjustment_type         = "ChangeInCapacity"
    cooldown                = 60
    metric_aggregation_type = "Maximum"

    step_adjustment {
      metric_interval_lower_bound = 0
      scaling_adjustment          = -1
    }
  }

  depends_on = [aws_appautoscaling_target.wordpress-autoscaling-target]
}
