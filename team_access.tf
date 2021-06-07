data "tfe_team" "rbac" {
  count = var.team_name != null ? 1 : 0

  name         = var.team_name
  organization = var.organization
}

resource "tfe_team_access" "rbac" {
  count = var.team_name != null ? 1 : 0

  workspace_id = tfe_workspace.ws.id
  team_id      = data.tfe_team.rbac[0].id
  access       = "read"
}