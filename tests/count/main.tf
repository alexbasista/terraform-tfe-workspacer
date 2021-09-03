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
  source = "../.."
  count  = var.workspace_count

  organization   = var.organization
  workspace_name = "${var.workspace_name_prefix}-${count.index}"
  workspace_desc = var.workspace_desc
}