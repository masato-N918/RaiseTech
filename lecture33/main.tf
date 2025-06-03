module "vpc" {
  source      = "./modules/vpc"
  vpc_cidr    = var.vpc_cidr
  pub_subnets = var.pub_subnets
  pri_subnets = var.pri_subnets
}

module "ec2" {
  source             = "./modules/ec2"
  subnet_id          = module.vpc.public_subnet_1a_id
  security_group_ids = [module.vpc.ec2_sg_id]
  instance_type      = var.instance_type
  key_name           = var.key_name
}

module "rds" {
  source                 = "./modules/rds"
  subnet_ids             = [module.vpc.private_subnet_1a_id]
  vpc_security_group_ids = [module.vpc.rds_sg_id]
  username               = var.username
  db_password            = var.db_password
  db_name                = var.db_name
}

module "alb" {
  source             = "./modules/alb"
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = [module.vpc.public_subnet_1a_id, module.vpc.public_subnet_1c_id]
  security_group_id  = module.vpc.elb_sg_id
  target_instance_id = module.ec2.instance_id
}

module "waf" {
  source  = "./modules/waf"
  alb_arn = module.alb.alb_arn
}

module "cloudwatch" {
  source      = "./modules/cloudwatch"
  instance_id = module.ec2.instance_id
}
