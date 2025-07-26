output "instance_ip" {
  description = "Ip of app_server "
  value       = aws_instance.app_server.public_ip
}
