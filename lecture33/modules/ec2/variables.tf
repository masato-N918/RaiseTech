variable "vpc_id" {
  description = "ID of the VPC"
}

variable "instance_type" {
  description = "EC2 instance type"
}

variable "subnet_id" {
  description = "subnet ID to launch EC2 instance in "
}

variable "key_name" {
  description = "name of the EC2 keypair"
}

variable "security_group_id" {
  description = "security group ID to associate with EC2 instance"
}
