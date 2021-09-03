terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.25.3"
    }
  }
}

provider "tfe" {
  hostname = var.tfe_hostname
}

module "tfe-workspace" {
  source = "../.."

  organization      = "tfeadmin"
  workspace_name    = "tfe-workspacer-module-with-vcs-test"
  workspace_desc    = "Terraform TFE Workspacer module CI testing."
  auto_apply        = true
  working_directory = "/tests/with-vcs/tf-working-dir-test"

  vcs_repo = {
    identifier     = "alexbasista/terraform-tfe-workspacer"
    branch         = "add-foreach-test"
    oauth_token_id = var.oauth_token_id
  }
}