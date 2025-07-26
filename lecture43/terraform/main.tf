# network
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "MyVPC"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "MyIGW"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "MyPubSub"
  }
}

resource "aws_route_table" "pubsubRT" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "MyPubSubRT"
  }
}

resource "aws_route" "default" {
  route_table_id         = aws_route_table.pubsubRT.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.pubsubRT.id
}


# app_server
data "aws_ssm_parameter" "amzn2023_latest" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

resource "aws_instance" "app_server" {
  ami                    = data.aws_ssm_parameter.amzn2023_latest.value
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.app_server.id]
  key_name               = var.key_name

  tags = {
    Name = "MyEC2"
  }
}

resource "aws_security_group" "app_server" {
  name        = "MyEC2SG"
  description = "Allow SSH, HTTP, and custom port"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "MyEC2SG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.app_server.id

  ip_protocol = "tcp"
  from_port   = 22
  to_port     = 22
  cidr_ipv4   = "143.189.176.201/32"
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.app_server.id

  ip_protocol = "tcp"
  from_port   = 80
  to_port     = 80
  cidr_ipv4   = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "allow_all" {
  security_group_id = aws_security_group.app_server.id

  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"
}
