terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.38.0"
    }
  }
}

provider "tfe" {
  hostname = var.tfe_hostname
}

module "workspacer" {
  source = "../.."

  organization          = var.organization
  workspace_name        = "aaaworkspacer-module-with-vcs-test"
  workspace_desc        = "Created by Terraform Workspacer module."
  workspace_tags        = ["module-ci", "test", "vcs-driven"]
  auto_apply            = true
  file_triggers_enabled = true
  queue_all_runs        = true
  trigger_prefixes      = null
  trigger_patterns      = null
  working_directory     = "/examples/with-vcs/tf-working-dir-test"

  vcs_repo = {
    identifier     = "alexbasista/terraform-tfe-workspacer"
    branch         = "feature-updates"
    oauth_token_id = var.oauth_token_id
  }
}