variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "ec2 instance type"
}

variable "pri_subnets" {
  type = map(string)
  default = {
    "1a" = "10.0.3.0/24"
    "1c" = "10.0.4.0/24"
  }
  description = "cidr blocks for private subnets"
}

variable "pub_subnets" {
  type = map(string)
  default = {
    "1a" = "10.0.1.0/24"
    "1c" = "10.0.2.0/24"
  }
  description = "cidr blocks for public subnets"
}

variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "cidr block for vpc"
}
