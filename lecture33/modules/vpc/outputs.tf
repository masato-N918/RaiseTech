output "ec2_sg_id" {
  description = "ID of security group for EC2 instance"
  value       = aws_security_group.app_server.id
}

output "elb_sg_id" {
  description = "ID of security group for application load balancer"
  value       = aws_security_group.alb.id
}

output "private_subnet_1a_id" {
  description = "ID of private subnet in AZ 1a"
  value       = aws_subnet.private_1a.id
}

output "private_subnet_1c_id" {
  description = "ID of private subnet in AZ 1c"
  value       = aws_subnet.private_1c.id
}

output "public_subnet_1a_id" {
  description = "ID of public subnet in AZ 1a"
  value       = aws_subnet.public_1a.id
}

output "public_subnet_1c_id" {
  description = "ID of public subnet in AZ 1c"
  value       = aws_subnet.public_1c.id
}

output "rds_sg_id" {
  description = "ID of security group for RDS instance"
  value       = aws_security_group.rds.id
}

output "vpc_id" {
  description = "ID of vpc"
  value       = aws_vpc.main.id
}


