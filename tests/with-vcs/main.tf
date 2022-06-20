terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.31.0"
    }
  }
}

provider "tfe" {
  hostname = var.tfe_hostname
}

module "workspacer" {
  source = "../.."

  organization      = var.organization
  workspace_name    = "workspacer-module-with-vcs-test"
  workspace_desc    = "Created by Terraform Workspacer module."
  auto_apply        = true
  working_directory = "/tests/with-vcs/tf-working-dir-test"

  vcs_repo = {
    identifier     = "alexbasista/terraform-tfe-workspacer"
    branch         = "main"
    oauth_token_id = var.oauth_token_id
  }
}