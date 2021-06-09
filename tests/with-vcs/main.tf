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
  workspace_name = "terraform-tfe-workspacer-with-vcs-test"
  workspace_desc = "Terraform module CI testing."
  
  vcs_repo = {
    identifier     = "alexbasista/terraform-random-thrones"
    branch         = "master"
    oauth_token_id = "ot-Mp48FwPYVbjSKnqd"
  }

  tfvars = {
    teststring = "iamstring"
    testlist   = ["1", "2", "3"]
    testmap    = { "a" = "1", "b" = "2", "c" = { "nest1key" = "nest1value"} }
  }

  tfvars_sensitive = {
    secret      = "secstring"
    secret_list = ["sec1", "sec2", "sec3"]
    secret_map  = {"x" = "sec4", "y" = "sec5", "z" = "sec6"}
  }

  envvars = {
    AWS_ACCESS_KEY_ID = "THISISNOTAREALACCESSKEY"
  }

  envvars_sensitive = {
    AWS_SECRET_ACCESS_KEY = "THISISNOTAREALSECRETKEY123!@#"
  }
}