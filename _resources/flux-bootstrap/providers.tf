terraform {
  required_providers {
    aws  = { 
      source = "hashicorp/aws"
      version = "~> 5.84.0" 
    }
    flux = { 
      source = "fluxcd/flux" 
      version = ">= 1.2" 
    }
    github = { 
      source = "integrations/github"
      version = "6.5.0" 
    }
  }
}

provider "aws" {
  region = var.aws_region
}

provider "flux" {
  kubernetes = {
    host = var.cluster_endpoint 
    cluster_ca_certificate = base64decode(var.cluster_ca_certificate)
    token = data.aws_eks_cluster_auth.cluster_auth.token 
  }
  git = {
    url = "https://github.com/${var.github_owner}/${var.github_repository}.git"
    http = {
      username = "git"
      password = data.aws_ssm_parameter.github_token.value 
    }
  }
}

provider "github" {
  owner = var.github_owner
  token = data.aws_ssm_parameter.github_token.value
}