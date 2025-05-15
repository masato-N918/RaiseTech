resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
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

resource "aws_subnet" "public_1a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.pub_subnets["1a"]
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "MyPubSub1a"
  }
}

resource "aws_subnet" "public_1c" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.pub_subnets["1c"]
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "MyPubSub1c"
  }
}

resource "aws_subnet" "private_1a" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.pri_subnets["1a"]
  availability_zone       = "ap-northeast-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "MyPriSub1a"
  }
}

resource "aws_subnet" "private_1c" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.pri_subnets["1c"]
  availability_zone       = "ap-northeast-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "MyPriSub1c"
  }
}


resource "aws_route_table" "pubsubRT" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "MyPubSubRT"
  }
}

resource "aws_route_table" "prisubRT" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "MyPriSubRT"
  }
}

resource "aws_route" "default" {
  route_table_id         = aws_route_table.pubsubRT.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

resource "aws_route_table_association" "public_1a" {
  subnet_id      = aws_subnet.public_1a.id
  route_table_id = aws_route_table.pubsubRT.id
}

resource "aws_route_table_association" "public_1c" {
  subnet_id      = aws_subnet.public_1c.id
  route_table_id = aws_route_table.pubsubRT.id
}

resource "aws_route_table_association" "private_1a" {
  subnet_id      = aws_subnet.private_1a.id
  route_table_id = aws_route_table.prisubRT.id
}

resource "aws_route_table_association" "private_1c" {
  subnet_id      = aws_subnet.private_1c.id
  route_table_id = aws_route_table.prisubRT.id
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
  from_port   = 0
  to_port     = 0
  cidr_ipv4   = "0.0.0.0/0"
}


resource "aws_security_group" "rds" {
  name        = "MyRDSSG"
  description = "Allow MySQL access from EC2 SG"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "MyRDSSG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_rds_from_ec2" {
  security_group_id            = aws_security_group.rds.id
  referenced_security_group_id = aws_security_group.app_server.id

  ip_protocol = "tcp"
  from_port   = 3306
  to_port     = 3306
}

resource "aws_vpc_security_group_egress_rule" "allow_all_from_rds" {
  security_group_id = aws_security_group.rds.id

  ip_protocol = "-1"
  from_port   = 0
  to_port     = 0
  cidr_ipv4   = "0.0.0.0/0"
}

resource "aws_security_group" "alb" {
  name        = "MyELBSG"
  description = "Allow HTTP"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "MyELBSG"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_https_to_elb" {
  security_group_id = aws_security_group.alb.id

  ip_protocol = "tcp"
  from_port   = 8080
  to_port     = 8080
  cidr_ipv4   = "0.0.0.0/0"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_from_elb" {
  security_group_id = aws_security_group.alb.id

  ip_protocol = "-1"
  from_port   = 0
  to_port     = 0
  cidr_ipv4   = "0.0.0.0/0"
}
