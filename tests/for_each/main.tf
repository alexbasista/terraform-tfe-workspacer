terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.25.3"
    }
  }

  experiments = [module_variable_optional_attrs]
}

provider "tfe" {
  hostname = var.tfe_hostname
}

module "tfe-workspace" {
  source   = "../.."
  for_each = var.workspaces

  organization   = var.organization
  workspace_name = each.value.name
  workspace_desc = each.value.description
}