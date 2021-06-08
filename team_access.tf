data "tfe_team" "managed" {
  for_each = var.team_access

  name         = each.key
  organization = var.organization
}

resource "tfe_team_access" "managed" {
  for_each = var.team_access

  workspace_id = tfe_workspace.ws.id
  team_id      = [ for t in [data.tfe_team.managed[each.key]] : t.id if t.name == each.key ][0]
  access       = each.value
}