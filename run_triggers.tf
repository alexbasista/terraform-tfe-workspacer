data "tfe_workspace_ids" "rt" {
  names        = var.run_trigger_source_workspaces
  organization = var.organization
}

resource "tfe_run_trigger" "rt" {
  for_each = data.tfe_workspace_ids.rt.ids

  workspace_id  = tfe_workspace.ws.id
  sourceable_id = each.value
}

output "run_trigger_workspace_ids" {
  value = data.tfe_workspace_ids.rt.ids
}