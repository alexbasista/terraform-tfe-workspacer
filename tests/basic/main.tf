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

  organization   = var.organization
  workspace_name = "workspacer-module-basic-test"
  workspace_desc = "Created by Terraform Workspacer module."

  envvars = {
    AWS_ACCESS_KEY_ID = "TH1SISNOTAREAL@CCESSKEY"
  }

  envvars_sensitive = {
    AWS_SECRET_ACCESS_KEY = "THISI$NOTAREALSECRETKEY123!@#"
  }

  team_access = {
    "dev-team"     = "read"
    "release-team" = "write"
  }
}