module "networking" {
  source       = "./modules/networking"
  project_name = var.project_name
  vpc_cidr     = var.vpc_cidr
}

module "sg" {
  source       = "./modules/sg"
  vpc_id       = module.networking.vpc_id
  project_name = var.project_name
  my_ip        = var.my_ip
  vpc_cidr     = var.vpc_cidr
}

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