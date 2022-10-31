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
  count  = 8

  organization   = var.organization
  workspace_name = "module-workspacer-count-test-${count.index}"
  workspace_desc = "Created by Terraform Workspacer module."
  workspace_tags = ["module-ci", "test", "aws"]
}