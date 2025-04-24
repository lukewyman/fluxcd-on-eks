include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${get_parent_terragrunt_dir()}/_resources/vpc"
}

inputs = {
  app_name            = "fluxcd-on-eks"
  aws_region          = "us-west-2"
  enable_nat_gateway  = false
  vpc_cidr_block      = "10.0.0.0/16"
  vpc_private_subnets = ["10.0.101.0/24", "10.0.102.0/24"]
  vpc_public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
}