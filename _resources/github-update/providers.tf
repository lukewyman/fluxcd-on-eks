terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "6.5.0"
    }
  }
}

provider "github" {
  owner = var.github_owner
  token = data.aws_ssm_parameter.github_token.value
}