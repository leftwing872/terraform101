resource "aws_launch_template" "my_launch_template" {
  name                   = "my-launch_template"
  image_id               = "ami-0bb84b8ffd87024d8"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.my_ec2_sg.id]
  user_data              = filebase64("./mod4/userdata.sh")
  tags = {
    "Name" = "my_ec2"
  }
}

resource "aws_autoscaling_group" "my_autoscaling_group" {
  name                = "my_asg"
  max_size            = 4
  min_size            = 2
  desired_capacity    = 2
  vpc_zone_identifier = [aws_subnet.my_pri_sub1.id, aws_subnet.my_pri_sub2.id]
  launch_template {
    id      = aws_launch_template.my_launch_template.id
    version = aws_launch_template.my_launch_template.latest_version
  }
  
  target_group_arns = [aws_lb_target_group.my_alb_target_group.arn]

  tag {
    key                 = "Name"
    value               = "my_asg_ec2"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "cpu_scaling_policy" {
  name                   = "my-cpu-scaling-policy"
  policy_type            = "TargetTrackingScaling"
  autoscaling_group_name = aws_autoscaling_group.my_autoscaling_group.name
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50
  }
}


