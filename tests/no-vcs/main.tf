terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.25.3"
    }
  }
}

module "tfe-workspace" {
  source = "../.."

  organization   = "terraform-tom"
  workspace_name = "terraform-tfe-workspacer-no-vcs-test"
  workspace_desc = "Terraform module CI testing."

  tfvars = {
      teststring = "iamstring"
      testlist   = ["1", "2", "3"]
      testmap    = { "a" = "1", "b" = "2", "c" = "3"}
  }

  tfvars_sensitive = {
      secret      = "secstring"
      secret_list = ["sec1", "sec2", "sec3"]
      secret_map  = {"x" = "sec4", "y" = "sec5", "z" = "sec6"}
  }

  envvars = {
      AWS_ACCESS_KEY_ID = "ABCDEFGHIJKLMNOPQRST"
  }

  envvars_sensitive = {
      AWS_SECRET_ACCESS_KEY = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$"
  }
}