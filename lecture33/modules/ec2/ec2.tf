variable "vpc_id" {}
variable "instance_type" {}
variable "subnet_id" {}
variable "key_name" {}
variable "security_group_id" {}

resource "aws_instance" "ec2" {
  ami           = data.aws_ssm_parameter.amzn2_latest.value
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  vpc_security_group_ids = var.security_group_id
  key_name      = var.key_name

  tags = {
    Name = "MyEC2"
  }
}

data "aws_ssm_parameter" "amzn2_latest" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

output "instance_id" {
  value = aws_instance.ec2.id
}
