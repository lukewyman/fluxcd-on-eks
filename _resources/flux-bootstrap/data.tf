data "aws_eks_cluster_auth" "cluster_auth" {
  name = var.eks_cluster_name
}

data "aws_ssm_parameter" "github_token" {
  name = "/app/${var.app_name}/flux/GITHUB_TOKEN"
  with_decryption = true 
}