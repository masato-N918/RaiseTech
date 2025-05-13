output "alb_arn" {
  value       = aws_lb.main_elb.arn
  description = "ARN of the application load balancer"
}
