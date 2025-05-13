variable "vpc_cidr" {
  default     = "10.0.0.0/16"
  description = "cidr block for vpc"
}

variable "pub_subnets" {
  type = map(string)
  default = {
    "1a" = "10.0.1.0/24"
    "1c" = "10.0.2.0/24"
  }
  description = "cidr block for public subnet"
}

variable "pri_subnets" {
  type = map(string)
  default = {
    "1a" = "10.0.3.0/24"
    "1c" = "10.0.4.0/24"
  }
  description = "cidr block for private subnet"
}

variable "instance_type" {
  default     = "t2.micro"
  description = "ec2 instance type"
}
