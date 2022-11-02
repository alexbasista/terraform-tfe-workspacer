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

  organization        = var.organization
  workspace_name      = "module-workspacer-full-test"
  workspace_desc      = "Created by Terraform Workspacer module."
  workspace_tags      = ["module-ci", "test", "aws"]
  auto_apply          = true
  execution_mode      = "remote"
  assessments_enabled = true
  global_remote_state = true
  terraform_version   = "1.3.3"
  working_directory   = "/"

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
    AWS_ACCESS_KEY_ID = "TH1$ISNOTAREAL@CCESSKEY"
  }

  envvars_sensitive = {
    AWS_SECRET_ACCESS_KEY = "THI$ISNOTAREALSECRETKEY123!@#"
    AWS_SESSION_TOKEN     = "THI$ISNOTAREALSESSIONTOKEN123456789$%^&*"
  }

  team_access = {
    "ops-team-test" = "admin"
  }

  custom_team_access = {
    dev-team-test = {
      runs              = "read"
      variables         = "read"
      state_versions    = "read-outputs"
      sentinel_mocks    = "read"
      workspace_locking = false
      run_tasks         = false
    }
    release-team-test = {
      runs              = "read"
      variables         = "write"
      state_versions    = "read"
      sentinel_mocks    = "none"
      workspace_locking = true
      run_tasks         = true
    }
  }

  notifications = [
    {
      name             = "test-notification-webhook"
      destination_type = "generic"
      url              = "https://example.com"
      token            = "abcdefg1234567"
      triggers         = ["run:completed", "run:errored"]
      enabled          = true
    }
  ]

  # Workspaces must already exist
  run_trigger_source_workspaces = [
    "rt-src1-test",
    "rt-src2-test"
  ]

  # Variable Sets must already exist
  variable_set_names = [
    "aws-creds-test",
    "tfe-token-test"
  ]
}