variable "subnet_ids" {
  description = "subnet IDs to launch the application load balancer in"
}

variable "security_group_id" {
  description = "ID to associate with the application load balancer"
}

variable "target_instance_id" {
  description = "ID of EC2 instance to register in the target group"
}

variable "vpc_id" {
  description = "ID of the VPC"
}

