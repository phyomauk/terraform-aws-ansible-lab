# VPC and subnets
module "networking" {
  source       = "./modules/networking"
  project_name = var.project_name
  vpc_cidr     = var.vpc_cidr
}

# security groups
module "sg" {
  source       = "./modules/sg"
  vpc_id       = module.networking.vpc_id
  project_name = var.project_name
  my_ips       = var.my_ips
  vpc_cidr     = var.vpc_cidr
}

# create 4 ec2 instances
module "ec2" {
  source             = "./modules/ec2"
  project_name       = var.project_name
  public_subnet_ids  = module.networking.public_subnet_ids
  private_subnet_ids = module.networking.private_subnet_ids
  db_subnet_ids      = module.networking.db_subnet_ids
  frontend_sg_id     = module.sg.frontend_sg_id
  db_sg_id           = module.sg.db_sg_id
  bastion_sg_id      = module.sg.bastion_sg_id
  key_name           = var.ec2-public-key
}

# ALB
module "alb" {
  source            = "./modules/alb"
  project_name      = var.project_name
  vpc_id            = module.networking.vpc_id
  public_subnet_ids = module.networking.public_subnet_ids
  alb_sg_id         = module.sg.alb_sg_id
  web_instance_ids  = module.ec2.web_instance_ids
  certificate_arn   = module.parameter_store.certificate_arn
}

# parameter store
module "parameter_store" {
  source       = "./modules/parameterstore"
  project_name = var.project_name
  site_domain  = var.site_domain
}

# Route53
module "route53" {
  source         = "./modules/route53"
  project_name   = var.project_name
  # domain_name    = var.domain_name
  hosted_zone_id = var.hosted_zone_id
  alb_zone_id    = module.alb.alb_zone_id
  alb_dns_name   = module.alb.alb_dns_name
}