data "tfe_variable_set" "vs" {
  for_each = toset(var.variable_set_names)

  name         = each.value
  organization = var.organization
}

resource "tfe_workspace_variable_set" "vs" {
  for_each = data.tfe_variable_set.vs

  variable_set_id = each.value.id
  workspace_id    = tfe_workspace.ws.id
}