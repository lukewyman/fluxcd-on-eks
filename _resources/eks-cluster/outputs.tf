output "aws_lbc_iam_role_arn" {
  value = aws_iam_role.lbc_iam_role.arn
}

output "cluster_certificate_authority_data" {
  value = module.eks.cluster_certificate_authority_data
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint 
}

output "cluster_name" {
  value = module.eks.cluster_name
}