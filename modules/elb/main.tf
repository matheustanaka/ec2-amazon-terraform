resource "aws_lb" "lb_ec2" {
  name               = "load-balancer-${terraform.workspace}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_allow_ssh]
  subnets            = [var.subnet_ec2_public_az_a, var.subnet_ec2_public_az_b]
  # subnets = [for subnet in var.subnet_ec2_public : subnet.id]

  enable_deletion_protection = false

  tags = {
    Name = "load balancer"
  }
}

resource "aws_lb_target_group" "lb_target_group" {
  name     = "lb-target-group-${terraform.workspace}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_ec2

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    protocol            = "HTTP"
    path                = "/"
    interval            = 10
  }

  tags = {
    Name = "load-balancer-target-group"
  }
}

resource "aws_lb_target_group_attachment" "lb_target_group_attachment" {
  for_each         = { for idx, id in var.ec2 : idx => id }
  target_group_arn = aws_lb_target_group.lb_target_group.arn
  target_id        = each.value # ID da instância EC2
  port             = 80
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.lb_ec2.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target_group.arn
  }
}

