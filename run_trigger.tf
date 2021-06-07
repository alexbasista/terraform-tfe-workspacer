resource "tfe_run_trigger" "rt" {
  count = var.run_trigger_source_ws_ids != null ? 1 : 0

  workspace_id  = tfe_workspace.ws.id
  sourceable_id = var.run_trigger_source_ws_ids
}