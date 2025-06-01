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
