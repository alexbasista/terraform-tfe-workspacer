data "tfe_policy_set" "ps" {
  for_each = toset(var.policy_set_names)

  name         = each.value
  organization = var.organization
}

resource "tfe_workspace_policy_set" "ps" {
  for_each = data.tfe_policy_set.ps
  
  policy_set_id = each.value.id
  workspace_id  = tfe_workspace.ws.id
}