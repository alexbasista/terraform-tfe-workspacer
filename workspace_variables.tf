locals {
  tfvars_files_args = [
    for file in var.tfvars_files : "-var-file=\"${var.tfvars_files_prefix}${file}\""
  ]
  # Add -var-file arguments to envvars, ensuring that any existing TF_CLI_ARGS_plan or TF_CLI_ARGS_apply are preserved
  envvars = merge(
    var.envvars,
    {
      TF_CLI_ARGS_plan  = trimspace(join(" ", concat([lookup(var.envvars, "TF_CLI_ARGS_plan", "")], local.tfvars_files_args)))
      TF_CLI_ARGS_apply = trimspace(join(" ", concat([lookup(var.envvars, "TF_CLI_ARGS_apply", "")], local.tfvars_files_args)))
    }
  )
  # Filter out any envvars with empty values to avoid setting them in the workspace
  envvars_filtered = { for k, v in local.envvars : k => v if v != "" }
}

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
  for_each = local.envvars_filtered

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
