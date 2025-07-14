module "networking" {
  source = "./modules/networking"

  project_name     = var.project_name
  aws_region       = var.aws_region
  azs              = var.azs
  environment      = var.environment
  vpc_cidr_block   = var.vpc_cidr_block
  private_subnets  = var.private_subnets
  public_subnets   = var.public_subnets
  database_subnets = var.database_subnets
}

module "bastion" {
  source = "./modules/bastion-host"

  project_name                   = var.project_name
  bastion_host_instance_type     = var.bastion_host_instance_type
  bastion_host_instance_key_name = var.bastion_host_instance_key_name
  vpc                            = module.networking.vpc
  sg                             = module.networking.sg
}

module "database" {
  source            = "./modules/database"
  project_name      = var.project_name
  vpc               = module.networking.vpc
  sg                = module.networking.sg
  db_instance_type  = var.db_instance_type
  db_engine         = var.db_engine
  db_engine_version = var.db_engine_version
  db_name           = var.db_name
}

module "autoscaling" {
  source = "./modules/autoscaling"

  project_name                     = var.project_name
  vpc                              = module.networking.vpc
  sg                               = module.networking.sg
  ec2_instance_type                = var.ec2_instance_type
  ec2_instance_key_name            = var.ec2_instance_key_name
  ec2_autoscaling_min_size         = var.ec2_autoscaling_min_size
  ec2_autoscaling_max_size         = var.ec2_autoscaling_max_size
  ec2_autoscaling_desired_capacity = var.ec2_autoscaling_desired_capacity
}
