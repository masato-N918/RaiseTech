variables {
  instance_type          = "t2.micro"
  subnet_id              = "subnet-123456789"
  security_group_ids = ["sg-123456789"]
  key_name               = "123456789"
}

run "instance_type_check" {

  command = plan

  assert {
    condition     = aws_instance.app_server.instance_type == "t2.micro"
    error_message = "インスタンスタイプが一致しません"
  }
}

run "subnet_check" {

  command = plan

  assert {
    condition     = aws_instance.app_server.subnet_id != ""
    error_message = "サブネットが未作成です"
  }
}

run "security_group_check" {

  command = plan

  assert {
    condition     = length(aws_instance.app_server.vpc_security_group_ids) > 0
    error_message = "セキュリティグループが未設定です"
  }
}

run "key_name_check" {

  command = plan

  assert {
    condition     = aws_instance.app_server.key_name == "123456789"
    error_message = "キーネームが一致しません"
  }
}
