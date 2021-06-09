terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.25.3"
    }
  }

  experiments = [module_variable_optional_attrs]
}

module "tfe-workspace" {
  source = "../.."

  organization   = "terraform-tom"
  workspace_name = "terraform-tfe-workspacer-full-test"
  workspace_desc = "Terraform module CI testing."

  tfvars = {
    teststring = "iamstring"
    testlist   = ["1", "2", "3"]
    testmap    = { "a" = "1", "b" = "2", "c" = { "nest1key" = "nest1value"} }
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
    AWS_SESSION_TOKEN     = "THISISNOTAREALSESSIONTOKEN123456789$%^&*"
  }

  team_access = {
    "test-invisible" = "read"
    "github-actions" = "write"
    "test"           = "admin"
  }

  custom_team_access = {
    "new-team" = {
      runs              = "read"
      variables         = "read"
      state_versions    = "read-outputs"
      sentinel_mocks    = "read"
      workspace_locking = true
    }
    "custom-team-perms" = {
      runs              = "read"
      variables         = "write"
      state_versions    = "read"
      sentinel_mocks    = "none"
      workspace_locking = false
    }
  }

  notifications = [
    {
      name             = "test-notification-email"
      destination_type = "email"
      email_user_ids   = ["abasista"]
      triggers         = ["run:completed", "run:errored"]
      enabled          = true
    }
  ]

  run_trigger_source_workspaces = [
    "my-new-ws",
    "new-ui-beta"
  ]
}