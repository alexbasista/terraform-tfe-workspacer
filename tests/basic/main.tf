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

  organization   = "tfeadmin"
  workspace_name = "tfe-workspacer-module-basic-test"
  workspace_desc = "Terraform TFE Workspacer module basic CI test."

  envvars = {
    AWS_ACCESS_KEY_ID = "THISISNOTAREALACCESSKEY"
  }

  envvars_sensitive = {
    AWS_SECRET_ACCESS_KEY = "THISISNOTAREALSECRETKEY123!@#"
  }

  team_access = {
    "dev-team"     = "read"
    "release-team" = "write"
  }
}