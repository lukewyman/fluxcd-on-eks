include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "${get_parent_terragrunt_dir()}/_resources/github-update"
}

dependency "eks-cluster" {
  config_path = "../eks-cluster"

  mock_outputs = {
    aws_lbc_iam_role_arn = "mock_aws_lbc_iam_role_arn"
  }
}

inputs = {
  app_name               = "fluxcd-on-eks"
  github_owner           = "lukewyman"
  github_repository_name = "istio-tasks-on-fluxcd"

  kustomize_patches = {
    "aws_load_balancer_controller" = {
      github_file = "flux/infrastructure/aws/test-file.yaml"
      template    = "test-file.tftpl"
      vars = {
        lbc_iam_role_arn = dependency.eks-cluster.outputs.aws_lbc_iam_role_arn
      }
    }
  }

  namespace = "dev"
}