variable "app_name" {
  type = string
}

variable "github_owner" {
  type = string
}

variable "github_repository_name" {
  type = string 
}

variable "kustomize_patches" {
  type = map(object({ github_file=string, template=string, vars=map(string) }))
}

variable "namespace" {
  type = string 
}