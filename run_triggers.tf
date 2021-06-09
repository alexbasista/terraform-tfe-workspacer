

resource "tfe_run_trigger" "rt" {
  for_each = var.run_trigger_source_workspaces

  workspace_id  = tfe_workspace.ws.id
  sourceable_id = var.run_trigger_source_workspaces
}