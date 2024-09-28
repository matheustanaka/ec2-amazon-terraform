module "ec2" {
  source                   = "./modules/ec2/"
  public_key               = var.public_key
  security_group_allow_ssh = module.network.security_group_allow_ssh
  environment              = var.environment[terraform.workspace]
  tag_name                 = var.tag_name[terraform.workspace]
  subnet_ec2_public_az_a   = module.network.subnet_ec2_public_az_a
  subnet_ec2_public_az_b   = module.network.subnet_ec2_public_az_b
  count_instance           = var.count_instance
}

module "network" {
  source      = "./modules/network/"
  environment = var.environment[terraform.workspace]
  tag_name    = var.tag_name[terraform.workspace]
}

module "elb" {
  source                   = "./modules/elb/"
  security_group_allow_ssh = module.network.security_group_allow_ssh
  subnet_ec2_public_az_a   = module.network.subnet_ec2_public_az_a
  subnet_ec2_public_az_b   = module.network.subnet_ec2_public_az_b
  vpc_ec2                  = module.network.vpc_ec2
  ec2                      = module.ec2.ec2
}
