include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${get_parent_terragrunt_dir()}/_resources/flux-bootstrap"
}

dependency "eks-cluster" {
  config_path = "../eks-cluster"

  mock_outputs = {
    cluster_certificate_authority_data = "bW9ja19jZXJ0X2F1dGhfZGF0YQ=="
    cluster_endpoint                   = "mock_cluster_endpoint"
    cluster_name                       = "mock_cluster_name"
  }
}

dependencies {
  paths = ["../github-update"]
}

inputs = {
  app_name               = "fluxcd-on-eks"
  aws_region             = "us-west-2"
  cluster_ca_certificate = dependency.eks-cluster.outputs.cluster_certificate_authority_data
  cluster_endpoint       = dependency.eks-cluster.outputs.cluster_endpoint
  eks_cluster_name       = dependency.eks-cluster.outputs.cluster_name
  github_owner           = "lukewyman"
  github_repository      = "istio-tasks-on-fluxcd"
}