variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "key_name" {
  type        = string
  description = "name of the EC2 keypair"
}

variable "security_group_ids" {
  type        = list(string)
  description = "security group ID to associate with EC2 instance"
}

variable "subnet_id" {
  type        = string
  description = "subnet ID to launch EC2 instance in"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC"
}

