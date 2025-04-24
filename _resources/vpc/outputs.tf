output "public_subnets" {
  value = module.istio_vpc.public_subnets
}

output "vpc_id" {
  value = module.istio_vpc.vpc_id
}