variable "vpc_cidr" {}
variable "pub_subnets" {
  type = map(string)
}

resource "aws_vpc" "main_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "MyVPC"
  }
}

resource "aws_internet_gateway" "main_igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "MyIGW"
  }
}

resource "aws_subnet" "public_1a" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.pub_subnets["1a"]
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "MyPubSub1a"
  }
}

resource "aws_subnet" "public_1c" {
  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = var.pub_subnets["1c"]
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "MyPubSub1c"
  }
}

resource "aws_route_table" "pubsubRT" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "MyPubSubRT"
  }
}

resource "aws_route" "default" {
  route_table_id         = aws_route_table.pubsubRT.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main_igw.id
}

resource "aws_route_table_association" "public_1a" {
  subnet_id      = aws_subnet.public_1a.id
  route_table_id = aws_route_table.pubsubRT.id
}

resource "aws_route_table_association" "public_1c" {
  subnet_id      = aws_subnet.public_1c.id
  route_table_id = aws_route_table.pubsubRT.id
}

resource "aws_security_group" "ec2_sg" {
  name        = "MyEC2SG"
  description = "Allow SSH, HTTP, and custom port"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["143.189.176.201/32"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "8080"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "MyEC2SG"
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "MyRDSSG"
  description = "Allow MySQL access from EC2 SG"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    description     = "MySQL"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "MyRDSSG"
  }
}

output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "public_subnet_1a_id" {
  value = aws_subnet.public_1a.id
}

output "public_subnet_1c_id" {
  value = aws_subnet.public_1c.id
}

output "ec2_sg_id" {
  value = aws_security_group.ec2_sg.id
}

output "rds_sg_id" {
  value = aws_security_group.rds_sg.id
}


