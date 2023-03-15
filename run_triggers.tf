data "tfe_workspace_ids" "run_triggers" {
  count = length(var.run_trigger_source_workspaces) == 0 ? 0 : 1

  names        = var.run_trigger_source_workspaces
  organization = var.organization
}

resource "tfe_run_trigger" "rt" {
  for_each = length(var.run_trigger_source_workspaces) == 0 ? {} : data.tfe_workspace_ids.run_triggers[0].ids

  workspace_id  = tfe_workspace.ws.id
  sourceable_id = each.value
}