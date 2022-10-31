data "tfe_team" "managed" {
  for_each = var.team_access

  name         = each.key
  organization = var.organization
}

resource "tfe_team_access" "managed" {
  for_each = var.team_access

  workspace_id = tfe_workspace.ws.id
  team_id      = [for t in [data.tfe_team.managed[each.key]] : t.id if t.name == each.key][0]
  access       = each.value
}

data "tfe_team" "custom" {
  for_each = var.custom_team_access

  name         = each.key
  organization = var.organization
}

resource "tfe_team_access" "custom" {
  for_each = var.custom_team_access

  workspace_id = tfe_workspace.ws.id
  team_id      = [for t in [data.tfe_team.custom[each.key]] : t.id if t.name == each.key][0]

  permissions {
    runs              = lookup(each.value, "runs", "read")
    variables         = lookup(each.value, "variables", "none")
    state_versions    = lookup(each.value, "state_versions", "none")
    sentinel_mocks    = lookup(each.value, "sentinel_mocks", "none")
    workspace_locking = lookup(each.value, "workspace_locking", false)
    run_tasks         = lookup(each.value, "run_tasks", false)
  }
}