variables {
  security_group_id  = "sg-123456789"
  subnet_ids         = ["subnet-123456789", "subnet-234567890"]
  target_instance_id = "i-123456789"
  vpc_id             = "vpc-123456789"
}

run "alb_check" {

  command = plan

  assert {
    condition     = length(aws_lb.alb.security_groups) > 0
    error_message = "セキュリティグループが未設定です"
  }

  assert {
    condition     = aws_lb.alb.load_balancer_type == "application"
    error_message = "ロードバランサーのタイプが一致しません"
  }

  assert {
    condition     = contains(aws_lb.alb.subnets, "subnet-123456789")
    error_message = "サブネットに紐づいていません"
  }
}

run "targetgroup_check" {

  command = plan

  assert {
    condition     = aws_lb_target_group.alb.port == 80
    error_message = "ターゲットグループのポートが一致しません"
  }
  assert {
    condition     = aws_lb_target_group.alb.protocol == "HTTP"
    error_message = "ターゲットグループプロトコルが一致しません"
  }
}

run "target_group_attachment_check" {

  command = plan

  assert {
    condition     = aws_lb_target_group_attachment.alb.target_id != ""
    error_message = "ターゲットインスタンスが未設定です"
  }

  assert {
    condition     = aws_lb_target_group_attachment.alb.port == 8080
    error_message = "ポートが一致しません"
  }
}

run "listener_check" {

  command = plan

  assert {
    condition     = aws_lb_listener.alb.port == 80
    error_message = "リスナーポートが一致しません"
  }

  assert {
    condition     = aws_lb_listener.alb.protocol == "HTTP"
    error_message = "リスナープロトコルが一致しません"
  }

  assert {
    condition     = aws_lb_listener.alb.default_action[0].type == "forward"
    error_message = "アクションタイプが一致しません"
  }
}
