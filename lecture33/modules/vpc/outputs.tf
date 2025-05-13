output "vpc_id" {
  value       = aws_vpc.main_vpc.id
  description = "ID of vpc"
}

output "public_subnet_1a_id" {
  value       = aws_subnet.public_1a.id
  description = "ID of public subnet in AZ 1a"
}

output "public_subnet_1c_id" {
  value       = aws_subnet.public_1c.id
  description = "ID of public subnet in AZ 1c"
}

output "private_subnet_1a_id" {
  value       = aws_subnet.private_1a.id
  description = "ID of private subnet in AZ 1a"
}

output "private_subnet_1c_id" {
  value       = aws_subnet.private_1c.id
  description = "ID of private subnet in AZ 1c"
}

output "ec2_sg_id" {
  value       = aws_security_group.ec2_sg.id
  description = "ID of security group for EC2 instance"
}

output "rds_sg_id" {
  value       = aws_security_group.rds_sg.id
  description = "ID of security group for RDS instance"
}

output "elb_sg_id" {
  value       = aws_security_group.elb_sg.id
  description = "ID of security group for application load balancer"
}
