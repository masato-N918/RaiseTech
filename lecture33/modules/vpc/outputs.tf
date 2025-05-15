output "ec2_sg_id" {
  value       = aws_security_group.app_server.id
  description = "ID of security group for EC2 instance"
}

output "elb_sg_id" {
  value       = aws_security_group.alb.id
  description = "ID of security group for application load balancer"
}

output "private_subnet_1a_id" {
  value       = aws_subnet.private_1a.id
  description = "ID of private subnet in AZ 1a"
}

output "private_subnet_1c_id" {
  value       = aws_subnet.private_1c.id
  description = "ID of private subnet in AZ 1c"
}

output "public_subnet_1a_id" {
  value       = aws_subnet.public_1a.id
  description = "ID of public subnet in AZ 1a"
}

output "public_subnet_1c_id" {
  value       = aws_subnet.public_1c.id
  description = "ID of public subnet in AZ 1c"
}

output "rds_sg_id" {
  value       = aws_security_group.rds.id
  description = "ID of security group for RDS instance"
}

output "vpc_id" {
  value       = aws_vpc.main.id
  description = "ID of vpc"
}


