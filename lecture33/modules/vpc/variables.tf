variable "vpc_cidr" {
  description = "cidr block for vpc"
}

variable "pub_subnets" {
  type        = map(string)
  description = "cidr block for public subnet"
}

variable "pri_subnets" {
  type        = map(string)
  description = "cidr block for private subnet"
}

