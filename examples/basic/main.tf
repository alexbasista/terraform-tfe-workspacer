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

  organization   = var.organization
  workspace_name = "module-workspacer-basic-test"
  workspace_desc = "Created by Terraform Workspacer module."
  workspace_tags = ["module-ci", "test", "aws"]

  envvars = {
    AWS_ACCESS_KEY_ID = "TH1SISNOTAREAL@CCESSKEY"
  }

  envvars_sensitive = {
    AWS_SECRET_ACCESS_KEY = "THISI$NOTAREALSECRETKEY123!@#"
  }

  team_access = {
    "dev-team-test"     = "read"
    "release-team-test" = "write"
  }
}