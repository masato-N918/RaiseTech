variable "db_name" {
  type        = string
  description = "name of the database instance"
}

variable "db_password" {
  type        = string
  description = "password for the master database user"
  sensitive = true
}

variable "instance_type" {
  type        = string
  description = "ec2 instance type"
  default     = "t2.micro"
}

variable "key_name" {
  type        = string
  description = "name of the ec2 instance key"
}

variable "pri_subnets" {
  type = map(string)
  description = "cidr blocks for private subnets"
  default = {
    "1a" = "10.0.3.0/24"
    "1c" = "10.0.4.0/24"
  }
}

variable "pub_subnets" {
  type = map(string)
  description = "cidr blocks for public subnets"
  default = {
    "1a" = "10.0.1.0/24"
    "1c" = "10.0.2.0/24"
  }
}

variable "username" {
  type        = string
  description = "username for the master database user"
}

variable "vpc_cidr" {
  type        = string
  description = "cidr block for vpc"
  default     = "10.0.0.0/16"
}
