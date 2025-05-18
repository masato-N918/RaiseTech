variable "db_name" {
  type        = string
  description = "name of the database instance"
}

variable "db_password" {
  type        = string
  description = "password for the master database user"
  sensitive   = true
}

variable "subnet_ids" {
  type        = list(string)
  description = "subnet IDs for the database subnet group"
}

variable "username" {
  type        = string
  description = "username for the master database user"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "VPC security group IDs to associate with the database instance"
}
