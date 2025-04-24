resource "github_repository_file" "mongodb_named_service" {
  for_each = var.kustomize_patches

  repository = var.github_repository_name
  branch = "main"
  file = each.value.github_file
  content = templatefile("${path.module}/templates/${each.value.template}",
    merge(each.value.vars, {namespace = var.namespace}))
  commit_message = "Post-tofu deploy - kustomize patch for ${each.key}"
  overwrite_on_create = true
}