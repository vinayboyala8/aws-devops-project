###############################################################################
# Base Network
###############################################################################

module "vpc" {
  source = "./vpc"

  aws_region                  = var.aws_region
  vpc_cidr_block              = var.vpc_cidr_block
  destination_cidr_block      = var.destination_cidr_block
  igw_tg                      = var.igw_tg
  vpc_tg                      = var.vpc_tg
  ssh_admin_tg                = var.ssh_admin_tg
  dub_alb_tg                  = var.dub_alb_tg
  
  demo_env_default_tags       = var.demo_env_default_tags
}

module "public-subnet" {
  source = "./public-subnet"

  aws_region                  = module.vpc.region
  vpc_id                      = module.vpc.id
  destination_cidr_block      = var.destination_cidr_block
  vpc_tg                      = var.vpc_tg
  igw_tg                      = var.igw_tg
  public_tg                   = var.public_tg
  public_rtb_tg               = var.public_rtb_tg  
  acls_public_prod_tg         = var.acls_public_prod_tg

  demo_env_default_tags       = module.vpc.demo_env_default_tags  
}

module "private-subnet" {
  source = "./private-subnet"
  
  aws_region                  = module.vpc.region
  vpc_id                      = module.vpc.id
  vpc_tg                      = var.vpc_tg
  private_tg                  = var.private_tg
  private_rtb_tg              = var.private_rtb_tg  
  acls_private_prod_tg        = var.acls_private_prod_tg

  demo_env_default_tags       = module.vpc.demo_env_default_tags  
}