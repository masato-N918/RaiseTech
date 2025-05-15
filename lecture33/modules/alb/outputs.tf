output "alb_arn" {
  value       = aws_lb.alb.arn
  description = "ARN of the application load balancer"
}
