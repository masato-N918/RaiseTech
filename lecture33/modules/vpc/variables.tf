variable "pri_subnets" {
  type        = map(string)
  description = "cidr blocks for private subnets"
}

variable "pub_subnets" {
  type        = map(string)
  description = "cidr blocks for public subnets"
}

variable "vpc_cidr" {
  type        = string
  description = "cidr block for vpc"
}
