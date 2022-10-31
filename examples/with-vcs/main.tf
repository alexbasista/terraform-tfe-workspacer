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
  workspace_name        = "module-workspacer-with-vcs-test"
  workspace_desc        = "Created by Terraform Workspacer module."
  workspace_tags        = ["module-ci", "test", "vcs-driven"]
  
  working_directory     = "/examples/with-vcs/tf-working-dir-test"
  auto_apply            = true
  file_triggers_enabled = true
  trigger_prefixes      = null # conflicts with `trigger_patterns`
  trigger_patterns      = ["/examples/with-vcs/tf-working-dir-test/**/*"]
  queue_all_runs        = true
  
  vcs_repo = {
    identifier     = "alexbasista/terraform-tfe-workspacer"
    branch         = "main"
    oauth_token_id = var.oauth_token_id
    tags_regex     = null # conflicts with `trigger_prefixes` and `trigger_patterns`
  }
}