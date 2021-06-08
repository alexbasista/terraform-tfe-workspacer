resource "tfe_notification_configuration" "note" {
  for_each = var.notifications

  workspace_id     = tfe_workspace.ws.id
  name             = each.value.name
  destination_type = each.value.destination_type
  url              = each.value.url
  token            = each.value.token
  email_addresses  = each.value.email_addresses
  email_user_ids   = each.value.email_user_ids
  triggers         = each.value.triggers
  enabled          = each.value.enabled
}