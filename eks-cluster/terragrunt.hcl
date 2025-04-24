include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${get_parent_terragrunt_dir()}/_resources/eks-cluster"
}

dependency "vpc" {
  config_path = "../vpc"

  mock_outputs = {
    public_subnets = ["mock_subnet_1", "mock_subnet_2"]
    vpc_id         = "mock_vpc_id"
  }
}

inputs = {
  app_name             = "fluxcd-on-eks"
  aws_region           = "us-west-2"
  cluster_version      = "1.32"
  ec2_ssh_key          = "karaoke-key-pair"
  instance_types       = ["t3.medium"]
  cluster_desired_size = 2
  cluster_max_size     = 3
  cluster_min_size     = 1
  subnet_ids           = dependency.vpc.outputs.public_subnets
  vpc_id               = dependency.vpc.outputs.vpc_id
}