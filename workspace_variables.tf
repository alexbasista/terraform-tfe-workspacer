resource "tfe_variable" "tfvars" {
  for_each = var.tfvars

  workspace_id = tfe_workspace.ws.id
  key          = each.key
  value        = try(tostring(each.value), "nostring") == "nostring" ? replace(jsonencode(each.value), ":", "=") : tostring(each.value)
  description  = "Managed by TFE Terraform provider."
  hcl          = try(tostring(each.value), "nostring") == "nostring" ? true : false
  sensitive    = false
  category     = "terraform"
}

resource "tfe_variable" "tfvars_sensitive" {
  for_each = var.tfvars_sensitive

  workspace_id = tfe_workspace.ws.id
  key          = each.key
  value        = try(tostring(each.value), "nostring") == "nostring" ? replace(jsonencode(each.value), ":", "=") : tostring(each.value)
  description  = "Managed by TFE Terraform provider."
  hcl          = try(tostring(each.value), "nostring") == "nostring" ? true : false
  sensitive    = true
  category     = "terraform"
}

resource "tfe_variable" "envvars" {
  for_each = var.envvars

  workspace_id = tfe_workspace.ws.id
  key          = each.key
  value        = each.value
  description  = "Managed by TFE Terraform provider."
  hcl          = false
  sensitive    = false
  category     = "env"
}

resource "tfe_variable" "envvars_sensitive" {
  for_each = var.envvars_sensitive

  workspace_id = tfe_workspace.ws.id
  key          = each.key
  value        = each.value
  description  = "Managed by TFE Terraform provider."
  hcl          = false
  sensitive    = true
  category     = "env"
}

resource "tfe_variable" "tfvars_ignore_changes" {
  for_each = var.tfvars_ignore_changes

  workspace_id = tfe_workspace.ws.id
  key          = each.key
  value        = try(tostring(each.value), "nostring") == "nostring" ? replace(jsonencode(each.value), ":", "=") : tostring(each.value)
  description  = "Managed by TFE Terraform provider."
  hcl          = try(tostring(each.value), "nostring") == "nostring" ? true : false
  sensitive    = false
  category     = "terraform"

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "tfe_variable" "envvars_ignore_changes" {
  for_each = var.envvars_ignore_changes

  workspace_id = tfe_workspace.ws.id
  key          = each.key
  value        = each.value
  description  = "Managed by TFE Terraform provider."
  hcl          = false
  sensitive    = false
  category     = "env"

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}