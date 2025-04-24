locals {
  aws_iam_oidc_connect_provider_extract_from_arn = element(split("oidc-provider/", "${module.eks.oidc_provider_arn}"), 1)
}