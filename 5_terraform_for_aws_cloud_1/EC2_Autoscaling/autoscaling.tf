resource "aws_key_pair" "levelup_key" {
  key_name   = "levelup_key"
  public_key = file(var.PATH_TO_PUBLIC_KEY)
}

resource "aws_launch_template" "levelup_launchtemplate" {
  name_prefix   = "levelup-launchtemplate"
  image_id      = lookup(var.AMIS, var.AWS_REGION)
  instance_type = "t2.micro"

  key_name = aws_key_pair.levelup_key.key_name

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "LevelUp Custom EC2 Instance"
    }
  }
}

data "aws_subnets" "default" {
  filter {
    name   = "default-for-az"
    values = ["true"]
  }
}

resource "aws_autoscaling_group" "levelup_autoscaling" {
  name = "levelup-autoscaling"

  min_size = 1
  max_size = 2

  health_check_type         = "EC2"
  health_check_grace_period = 200
  force_delete              = true

  vpc_zone_identifier = data.aws_subnets.default.ids

  launch_template {
    id      = aws_launch_template.levelup_launchtemplate.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "LevelUp Custom EC2 Instance"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "levelup_cpu_policy" {
  name                   = "levelup-cpu-policy"
  autoscaling_group_name = aws_autoscaling_group.levelup_autoscaling.name

  adjustment_type    = "ChangeInCapacity"
  scaling_adjustment = 1
  cooldown           = 200
  policy_type        = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "levelup_cpu_alarm" {
  alarm_name          = "levelup-cpu-alarm"
  alarm_description   = "Scale up when CPU exceeds 30%"

  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2

  metric_name = "CPUUtilization"
  namespace   = "AWS/EC2"
  period      = 120
  statistic   = "Average"
  threshold   = 30

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.levelup_autoscaling.name
  }

  alarm_actions = [
    aws_autoscaling_policy.levelup_cpu_policy.arn
  ]
}

resource "aws_autoscaling_policy" "levelup_cpu_policy_scaledown" {
  name                   = "levelup-cpu-policy-scaledown"
  autoscaling_group_name = aws_autoscaling_group.levelup_autoscaling.name

  adjustment_type    = "ChangeInCapacity"
  scaling_adjustment = -1
  cooldown           = 200
  policy_type        = "SimpleScaling"
}

resource "aws_cloudwatch_metric_alarm" "levelup_cpu_alarm_scaledown" {
  alarm_name          = "levelup-cpu-alarm-scaledown"
  alarm_description   = "Scale down when CPU falls below 10%"

  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 2

  metric_name = "CPUUtilization"
  namespace   = "AWS/EC2"
  period      = 120
  statistic   = "Average"
  threshold   = 10

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.levelup_autoscaling.name
  }

  alarm_actions = [
    aws_autoscaling_policy.levelup_cpu_policy_scaledown.arn
  ]
}