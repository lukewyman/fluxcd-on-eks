module "istio_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.17.0"

  name            = "${var.app_name}-vpc"
  cidr            = var.vpc_cidr_block
  azs             = data.aws_availability_zones.available.names
  public_subnets  = var.vpc_public_subnets
  private_subnets = var.vpc_private_subnets

  create_database_subnet_group       = false

  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  map_public_ip_on_launch = true
}