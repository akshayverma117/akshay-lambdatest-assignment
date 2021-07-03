module "vpc" {
  source                             = "../../modules/vpc_module"
  create_vpc                         = var.create_vpc
  name                               = join("-", [var.project_name, var.env_name, "vpc"])
  cidr                               = var.vpc_cidr
  azs                                = var.azs
  private_subnets                    = var.private_subnets
  public_subnets                     = var.public_subnets
  enable_nat_gateway                 = true
  enable_vpn_gateway                 = true
  single_nat_gateway                 = true
  create_database_subnet_group       = false
  create_database_nat_gateway_route  = false
  create_database_subnet_route_table = false
  create_igw                         = true
  enable_dns_hostnames               = true
  enable_ecs_endpoint                = false
  tags = {
    Terraform   = "true"
    Environment = var.env_name
  }
}
