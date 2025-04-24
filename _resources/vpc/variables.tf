variable "app_name" {
  type = string 
}

variable "aws_region" {
  type = string 
}

variable "enable_nat_gateway" {
  type = bool
}

variable "vpc_cidr_block" {
  type = string
}

variable "vpc_private_subnets" {
    type = list(string)
}

variable "vpc_public_subnets" {
    type = list(string)
}