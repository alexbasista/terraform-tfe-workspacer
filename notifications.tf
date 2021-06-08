resource "tfe_notification_configuration" "note" {
  for_each = var.notifications

  workspace_id     = tfe_workspace.ws.id
  name             = each.value.name
  destination_type = var.notification_dest_type
  url              = var.notification_url
  token            = var.notification_token
  triggers         = var.notification_triggers
  enabled          = var.notification_enabled
  email_addresses  = var.notification_email_addresses
  email_user_ids   = var.notification_email_user_ids
}