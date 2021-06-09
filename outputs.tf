output "workspace_id" {
  value       = tfe_workspace.ws.id
  description = "ID of Workspace."
}

output "run_trigger_source_workspace_ids" {
  value       = data.tfe_workspace_ids.rt.ids
  description = "IDs of source Workspaces of run triggers."
}