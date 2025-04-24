variable "app_name" {
  type = string 
}

variable "aws_region" {
  type = string
}

variable "cluster_version" {
  type = string 
}

variable "ec2_ssh_key" {
  type = string
}

variable "instance_types" {
  type = list(string)
}

variable "cluster_desired_size" {
  type = number 
}

variable "cluster_max_size" {
  type = number
}

variable "cluster_min_size" {
  type = number
}

variable "subnet_ids" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}