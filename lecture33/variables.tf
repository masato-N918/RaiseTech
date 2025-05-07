variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "pub_subnets" {
  type = map(string)
  default = {
    "1a" = "10.0.1.0/24"
    "1c" = "10.0.2.0/24"
  }
}

variable "pri_subnets" {
  type = map(string)
  default = {
    "1a" = "10.0.3.0/24"
    "1c" = "10.0.4.0/24"
  }
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  default = "udemysample"
}

variable "db_name" {
  default = "awsstudy"
}

variable "db_username" {
  default = "root"
}
# 直接記述しない。SSM？
variable "db_password" {
  default = "rootroot"
}
