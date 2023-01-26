
# ================>  Root main.tf  <===============#

module "network" {
  source              = "./network"
  vpc_cidrBlock       = var.cidr_block_vpc
  vpc_name            = var.vpc_name
  public_sn_count     = 4
  public_sn_cidr      = var.public_sn_cidr
  web_security_groups = local.security_groups.webServer
  alb_security_groups = local.security_groups.alb_sg
}

module "loadbalancing"{
    source = "./loadbalancer"
    subnet_ids = module.network.subnet_ids
    public_sg_id = module.network.albsg_id
    vpc_id = module.network.vpc_id
}
