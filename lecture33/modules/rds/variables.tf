variable "subnet_ids" {
  description = "subnet IDs for the database subnet group"
}

variable "username" {
  description = "username for the master database user"
}

variable "db_password" {
  description = "name of the master database user"
}

variable "db_name" {
  description = "name of the database instance"
}

variable "vpc_security_group_ids" {
  description = "VPC security group IDs to associate with the database instance"
}
