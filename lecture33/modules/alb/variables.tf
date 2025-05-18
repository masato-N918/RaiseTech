variable "security_group_id" {
  type        = string
  description = "ID to associate with the application load balancer"
}

variable "subnet_ids" {
  type        = list(string)
  description = "subnet IDs to launch the application load balancer in"
}

variable "target_instance_id" {
  type        = string
  description = "ID of EC2 instance to register in the target group"
}

variable "vpc_id" {
  type        = string
  description = "ID of the VPC"
}

