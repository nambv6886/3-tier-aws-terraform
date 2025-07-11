data "aws_ami" "ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  owners = ["amazon"]
}

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "9.17.0"

  name            = "${var.project_name}-alb"
  vpc_id          = var.vpc.vpc_id
  subnets         = var.vpc.public_subnets
  security_groups = [var.sg.alb_sg]

  enable_deletion_protection = false

  listeners = {
    http = {
      port     = 80
      protocol = "HTTP"

      forward = {
        target_group_key = "web"
      }
    }
  }

  // https configuration
  # listeners = {
  #   ex-http-https-redirect = {
  #     port     = 80
  #     protocol = "HTTP"
  #     redirect = {
  #       port        = "443"
  #       protocol    = "HTTPS"
  #       status_code = "HTTP_301"
  #     }
  #   }
  #   ex-https = {
  #     port            = 443
  #     protocol        = "HTTPS"
  #     certificate_arn = "arn:aws:iam::123456789012:server-certificate/test_cert-123456789012"

  #     forward = {
  #       target_group_key = "ex-instance"
  #     }
  #   }
  # }

  target_groups = {
    web = {
      # VERY IMPORTANT: We will create aws_lb_target_group_attachment resource separately 
      # when we use create_attachment = false, refer above GitHub issue URL.
      # Github ISSUE: https://github.com/terraform-aws-modules/terraform-aws-alb/issues/316
      # Search for "create_attachment" to jump to that Github issue solution
      create_attachment = false

      name_prefix = "web-"
      protocol    = "HTTP"
      port        = 80
      target_type = "instance"

      health_check = {
        enabled             = true
        interval            = 30
        path                = "/"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
        protocol            = "HTTP"
        matcher             = "200-399"
      }

    }
  }
}

resource "aws_launch_template" "web" {
  name_prefix            = "web-"
  image_id               = data.aws_ami.ami.id
  instance_type          = var.ec2_instance_type
  vpc_security_group_ids = [var.sg.web_sg]
  key_name               = var.ec2_instance_key_name
  user_data              = filebase64("${path.module}/user-data.sh")
  // todo
  # iam_instance_profile {
  #   name = "${var.project_name}-web-instance-profile"
  # }

  block_device_mappings {
    device_name = "/dev/sda1"
    ebs {
      volume_size           = 10
      volume_type           = "gp2"
      delete_on_termination = true
    }
  }
}

resource "aws_autoscaling_group" "web" {
  name = "${var.project_name}-web-asg"
  launch_template {
    id      = aws_launch_template.web.id
    version = "$Latest"
  }
  vpc_zone_identifier = var.vpc.private_subnets
  min_size            = var.ec2_autoscaling_min_size
  max_size            = var.ec2_autoscaling_max_size
  desired_capacity    = var.ec2_autoscaling_desired_capacity

  health_check_type         = "ELB"
  health_check_grace_period = 300

  target_group_arns = [
    module.alb.target_groups["web"].arn
  ]

  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
    triggers = ["desired_capacity"]
  }
}

resource "aws_autoscaling_policy" "avg_cpu_scale_up" {
  name        = "${var.project_name}-web-asg-scale-up"
  policy_type = "TargetTrackingScaling"
  target_tracking_configuration {
    target_value = 50.0
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
  }

  autoscaling_group_name = aws_autoscaling_group.web.name
}

resource "aws_autoscaling_policy" "alb_target_requests_scale_up" {
  name        = "${var.project_name}-web-asg-alb-scale-up"
  policy_type = "TargetTrackingScaling"
  target_tracking_configuration {
    target_value = 100.0
    predefined_metric_specification {
      predefined_metric_type = "ALBRequestCountPerTarget"
      resource_label         = "${module.alb.arn_suffix}/${module.alb.target_groups["web"].arn_suffix}"
    }
  }

  autoscaling_group_name = aws_autoscaling_group.web.name
}
