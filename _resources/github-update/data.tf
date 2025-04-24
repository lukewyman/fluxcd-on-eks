data "aws_ssm_parameter" "github_token" {
  name = "/app/${var.app_name}/flux/GITHUB_TOKEN"
  with_decryption = true 
}