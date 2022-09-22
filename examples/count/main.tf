terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.36.1"
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
  workspace_name = "workspacer-module-count-test-${count.index}"
  workspace_desc = "Created by Terraform Workspacer module."
  workspace_tags = ["module-ci", "test", "aws"]
}