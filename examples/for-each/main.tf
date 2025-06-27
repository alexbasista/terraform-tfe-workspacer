provider "tfe" {
  hostname = var.tfe_hostname
}

module "workspacer" {
  source   = "alexbasista/workspacer/tfe"
  version  = "0.13.0"
  for_each = var.workspaces

  organization       = var.organization
  workspace_name     = each.value.name
  workspace_desc     = each.value.description
  workspace_map_tags = each.value.tags
  project_name       = each.value.project_name
  vcs_repo           = each.value.vcs_repo
}