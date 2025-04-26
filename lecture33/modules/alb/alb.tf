resource "aws_lb" "main_elb" {
  name               = "MyELB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.security_group_id]
  subnets            = var.subnet_ids

  tags = {
    Name = "MyELB"
  }
}

resource "aws_lb_target_group" "elb_tg" {
  name        = "MyELBTG"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = data.aws_vpc.default.id

  health_check {
    path                = "/"
    interval            = 10
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }

  tags = {
    Name = "MyELBTG"
  }
}

resource "aws_lb_target_group_attachment" "elb_attachment" {
  target_group_arn = aws_lb_target_group.elb_tg.arn
  target_id        = var.target_instance_id
  port             = 8080
}

resource "aws_lb_listener" "elb_listener" {
  load_balancer_arn = aws_lb.main_elb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.elb_tg.arn
  }
}

data "aws_vpc" "default" {
  default = true
}

output "alb_arn" {
  value = aws_lb.main_elb.arn
}
