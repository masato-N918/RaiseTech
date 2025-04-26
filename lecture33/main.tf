module "vpc" {
  source = "./modules/vpc"
  vpc_cidr   = var.vpc_cidr
  pub_subnets = var.pub_subnets
}

module "ec2" {
  source = "./modules/ec2"
  subnet_id        = module.network.public_subnet_1a_id
  security_group_id = module.network.ec2_sg_id
  instance_type     = var.instance_type
  key_name          = var.key_name
}

module "rds" {
  source = "./modules/rds"
  subnet_ids        = [module.network.public_subnet_1a_id, module.network.public_subnet_1c_id]
  vpc_security_group_ids = [module.network.rds_sg_id]
  db_username       = var.db_username
  db_password       = var.db_password
}

module "alb" {
  source = "./modules/alb"
  subnet_ids = [module.network.public_subnet_1a_id, module.network.public_subnet_1c_id]
  security_group_id = module.network.ec2_sg_id
  target_instance_id = module.ec2.instance_id
}

module "waf" {
  source = "./modules/waf"
  alb_arn = module.alb.alb_arn
}

module "cloudwatch" {
  source = "./modules/cloudwatch"
  instance_id = module.ec2.instance_id
}
