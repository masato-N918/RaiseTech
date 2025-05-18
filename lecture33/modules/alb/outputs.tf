output "alb_arn" {
  description = "ARN of the application load balancer"
  value       = aws_lb.alb.arn
}
