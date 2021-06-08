# resource "tfe_notification_configuration" "note" {
#   count = var.notification_name != null && var.notification_dest_type != null ? 1 : 0

#   workspace_id     = tfe_workspace.ws.id
#   destination_type = var.notification_dest_type
#   name             = var.notification_name
#   url              = var.notification_url
#   token            = var.notification_token
#   triggers         = var.notification_triggers
#   enabled          = var.notification_enabled
#   email_addresses  = var.notification_email_addresses
#   email_user_ids   = var.notification_email_user_ids
# }