# terraform-tfe-workspacer
Terraform module to create and configure Workspaces in Terraform Cloud/Enterprise.

## Usage
```hcl
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
  workspace_name = "terraform-tfe-workspacer-no-vcs-test"
  workspace_desc = "Terraform module CI testing."

  tfvars = {
    teststring = "iamstring"
    testlist   = ["1", "2", "3"]
    testmap    = { "a" = "1", "b" = "2", "c" = "3" }
  }

  tfvars_sensitive = {
    secret      = "secstring"
    secret_list = ["sec1", "sec2", "sec3"]
    secret_map  = { "x" = "sec4", "y" = "sec5", "z" = "sec6" }
  }

  envvars = {
    AWS_ACCESS_KEY_ID = "ABCDEFGHIJKLMNOPQRST"
  }

  envvars_sensitive = {
    AWS_SECRET_ACCESS_KEY = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$"
  }
}
```

### Basic

### With VCS

### Workspace Variables

### Team Access
To add RBAC to the Workspace, there are two options. 

#### Built-In Permissions
The `team_access` input variable accepts a map of strings; in this case each key/value pair being the existing Team name and built-in permission level.

```hcl
  team_access = {
    "dev-team"     = "read"
    "release-team" = "write"
    "ops-team"     = "admin"
  }
```

#### Custom Permissions
The `custom_team_access` input variable accepts a map of objects; in this case each object being five key/value pairs of custom permissions levels. The way the TFE provider and API work, all five of the key/value pairs must be specified together when using.

```hcl
  custom_team_access = {
    "app-team" = {
      runs              = "read"
      variables         = "read"
      state_versions    = "read"
      sentinel_mocks    = "none"
      workspace_locking = false
    }
    "security-team" = {
      runs              = "plan"
      variables         = "write"
      state_versions    = "read-outputs"
      sentinel_mocks    = "read"
      workspace_locking = true
    }
  }
```

### Notifications
To create notifications, the `notifications` input variable accepts a list of objects; in this case each object being a notification configuration.

```hcl
  notifications = [
    {
      name             = "test-notification-generic"
      destination_type = "generic"
      url              = "http://example.com/tfe-notifications-api"
      token            = "abcdefg123456789"
      triggers         = ["run:needs_attention"]
      enabled          = true
    },
    {
      name             = "test-notification-email"
      destination_type = "email"
      email_user_ids   = ["abasista"]
      triggers         = ["run:completed", "run:errored"]
      enabled          = true
    },
    {
      name             = "test-notification-slack"
      destination_type = "slack"
      url              = "https://hooks.slack.com/test"
      triggers         = ["run:completed", "run:errored"]
      enabled          = true
    }
  ]
}
```

### Run Triggers
Coming soon.