variables {
  pri_subnets = {
    "1a" = "10.0.3.0/24"
    "1c" = "10.0.4.0/24"
  }
  pub_subnets = {
    "1a" = "10.0.1.0/24"
    "1c" = "10.0.2.0/24"
  }
  vpc_cidr = "10.0.0.0/16"
}

run "valid_public_destination_cidr_block" {

  command = plan

  assert {
    condition     = aws_route.default.destination_cidr_block == "0.0.0.0/0"
    error_message = "default destination cidr block did not match expected"
  }
}

run "vpc_sg_ingress_rule_ssh" {

  command = plan

  assert {
    condition     = aws_vpc_security_group_ingress_rule.allow_ssh.from_port == 22
    error_message = "port did not match expected"
  }

  assert {
    condition     = aws_vpc_security_group_ingress_rule.allow_ssh.to_port == 22
    error_message = "port did not match expected"
  }
}

run "vpc_sg_ingress_rule_http" {

  command = plan

  assert {
    condition     = aws_vpc_security_group_ingress_rule.allow_http.from_port == 80
    error_message = "port did not match expected"
  }

  assert {
    condition     = aws_vpc_security_group_ingress_rule.allow_http.to_port == 80
    error_message = "port did not match expected"
  }
}

run "vpc_sg_egress_rule_all" {

  command = plan

  assert {
    condition     = aws_vpc_security_group_egress_rule.allow_all.from_port == 0
    error_message = "port did not match expected"
  }

  assert {
    condition     = aws_vpc_security_group_egress_rule.allow_all.to_port == 0
    error_message = "port did not match expected"
  }
}

run "vpc_sg_ingress_rule_rds_from_ec2" {

  command = plan

  assert {
    condition     = aws_vpc_security_group_ingress_rule.allow_rds_from_ec2.from_port == 3306
    error_message = "port did not match expected"
  }

  assert {
    condition     = aws_vpc_security_group_ingress_rule.allow_rds_from_ec2.to_port == 3306
    error_message = "port did not match expected"
  }
}

run "vpc_sg_egress_rule_all_from_rds" {

  command = plan

  assert {
    condition     = aws_vpc_security_group_egress_rule.allow_all_from_rds.from_port == 0
    error_message = "port did not match expected"
  }

  assert {
    condition     = aws_vpc_security_group_egress_rule.allow_all_from_rds.to_port == 0
    error_message = "port did not match expected"
  }
}

run "vpc_sg_ingress_rule_https_to_elb" {

  command = plan

  assert {
    condition     = aws_vpc_security_group_ingress_rule.allow_https_to_elb.from_port == 8080
    error_message = "port did not match expected"
  }

  assert {
    condition     = aws_vpc_security_group_ingress_rule.allow_https_to_elb.to_port == 8080
    error_message = "port did not match expected"
  }
}

run "vpc_sg_egress_rule_https_to_elb" {

  command = plan

  assert {
    condition     = aws_vpc_security_group_egress_rule.allow_all_from_elb.from_port == 0
    error_message = "port did not match expected"
  }

  assert {
    condition     = aws_vpc_security_group_egress_rule.allow_all_from_elb.to_port == 0
    error_message = "port did not match expected"
  }
}

run "vpc_cidr_block" {

  command = plan

  assert {
    condition     = aws_vpc.main.cidr_block == "10.0.0.0/16"
    error_message = "VPC CIDR block did not match expected"
  }
}

run "igw_check" {

  command = plan

  assert {
    condition     = aws_internet_gateway.main.tags.Name == "MyIGW"
    error_message = "Internet Gateway not created"
  }
}

run "subnet_public_ip_check" {

  command = plan

  assert {
    condition     = aws_subnet.public_1a.map_public_ip_on_launch == true
    error_message = "Public subnet 1a does not have map_public_ip_on_launch enabled"
  }

  assert {
    condition     = aws_subnet.public_1c.map_public_ip_on_launch == true
    error_message = "Public subnet 1c does not have map_public_ip_on_launch enabled"
  }
}
