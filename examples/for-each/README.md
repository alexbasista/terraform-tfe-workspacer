# Example - Using the `for_each` Meta-Argument

```hcl
module "workspacer" {
  source   = "alexbasista/workspacer/tfe"
  version  = "0.11.0"
  for_each = var.workspaces

  organization   = var.organization
  workspace_name = each.value.name
  workspace_desc = each.value.description
  workspace_tags = each.value.tags
  project_name   = each.value.project_name
  vcs_repo       = each.value.vcs_repo
}
```