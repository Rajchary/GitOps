
# ================>  Root main.tf  <===============#

module "network" {
  source              = "./network"
  env                 = var.env
  vpc_cidrBlock       = var.cidr_block_vpc
  vpc_name            = var.vpc_name
  public_sn_count     = 4
  public_sn_cidr      = var.public_sn_cidr
  web_security_groups = local.security_groups.webServer
  alb_security_groups = local.security_groups.alb_sg
}

module "loadbalancing" {
  source       = "./loadbalancer"
  env          = var.env
  subnet_ids   = module.network.subnet_ids
  public_sg_id = module.network.albsg_id
  vpc_id       = module.network.vpc_id
}

module "compute" {
  source                 = "./compute"
  env                    = var.env
  instance_count         = var.instance_count
  ami_id                 = var.ami_id
  instance_type          = "t2.micro"
  instance_name          = "Home-App"
  public_key             = var.pub_key
  webServer_sg_id        = module.network.websg_id
  subnet_ids             = module.network.subnet_ids
  userData_path          = "${path.root}/userData.sh"
  template_userData_path = "${path.root}/templateUserData.sh"
  tg_products_arn        = module.loadbalancing.products_tg_arn
  tg_home_arn            = module.loadbalancing.home_tg_arn

  #======> AutoScaling Group Configuration (Stand-By)<======

  #   max_instance_size      = var.asg_max_instance_size
  #   min_instance_size      = var.asg_min_instance_size
  #   desired_instance_size  = var.asg_desired_instance_size
  #   asg_name               = var.asg_name
  #   launch_template_name   = var.launch_template_name

}

