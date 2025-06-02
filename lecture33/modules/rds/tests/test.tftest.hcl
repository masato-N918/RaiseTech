variables {
  db_name                = "dbname"
  db_password            = "password"
  subnet_ids             = ["subnet-123456789"]
  username               = "username"
  vpc_security_group_ids = ["sg-123456789"]
}

run "subnet_group_check" {

  command = plan

  assert {
    condition     = contains(aws_db_subnet_group.main.subnet_ids, "subnet-123456789")
    error_message = "サブネットグループに紐づいていません"
  }
}

run "db_instance_check" {

  command = plan

  assert {
    condition     = aws_db_instance.main.engine == "mysql"
    error_message = "データベースの種類が一致しません"
  }

  assert {
    condition     = aws_db_instance.main.engine_version == "8.0.41"
    error_message = "データベースのバージョンが一致しません"
  }

  assert {
    condition     = aws_db_instance.main.instance_class == "db.t4g.micro"
    error_message = "データベースのインスタンスが一致しません"
  }
}
