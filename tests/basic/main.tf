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

  tfvars = {
    teststring = "iamstring"
    testlist   = ["1", "2", "3"]
    testmap    = { "a" = "1", "b" = "2", "c" = { "nest1key" = "nest1value" } }
  }

  tfvars_sensitive = {
    secret      = "secstring"
    secret_list = ["sec1", "sec2", "sec3"]
    secret_map  = { "x" = "sec4", "y" = "sec5", "z" = "sec6" }
  }

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