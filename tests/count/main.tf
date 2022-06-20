terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.31.0"
    }
  }

  experiments = [module_variable_optional_attrs]
}

provider "tfe" {
  hostname = var.tfe_hostname
}

module "workspacer" {
  source = "../.."
  count  = 8

  organization   = var.organization
  workspace_name = "workspacer-module-count-test-${count.index}"
  workspace_desc = "Created by Terraform Workspacer module."
}