variable "subnet_ids" {}
variable "db_username" {}
variable "db_password" {}
variable "vpc_security_group_ids" {}

resource "aws_db_subnet_group" "dbsubnetgroup" {
  name       = "mydbsubnetgroup"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "MyRDSSubnetGroup"
  }
}

resource "aws_db_instance" "main_rds" {
  allocated_storage      = 20
  engine                 = "mysql"
  engine_version         = "8.0.41"
  instance_class         = "db.t4g.micro"
  db_name                = "awsstudy"
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.dbsubnetgroup.name
  vpc_security_group_ids = var.vpc_security_group_ids
  skip_final_snapshot    = true

  tags = {
    Name = "MyRDS"
  }
}
