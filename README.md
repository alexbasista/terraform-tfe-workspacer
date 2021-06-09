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
  source = "https://github.com/alexbasista/terraform-tfe-workspacer"

  organization   = "my-tfe-org"
  workspace_name = "my-new-tfe-ws"
  workspace_desc = "Description of my new TFE Workspace."

  tfvars = {
    teststring = "iamstring"
    testlist   = ["1", "2", "3"]
    testmap    = { "a" = "1", "b" = "2", "c" = "3" }
  }
}
```

### With VCS
The optional `vcs_repo` input variable expects a map of strings
```hcl
  vcs_repo {
    identifier     = "alexbasista/terraform-tfe-workspacer"
    branch         = "main"
    oauth_token_id = var.oauth_token_id
  }
```

### Workspace Variables
This modules strives to make defining and creating Workspace Variables as streamlined as possible and closer to the `terraform.tfvars` user experience of key/value pairs. There are four different optional input variables available to create Workspace Variables.

#### Terraform Variables
`tfvars` accepts a map of key/value pairs of any type, and `tfvars_sensitive` is the same except it will also mark the variable(s) as sensitive upon creation.
```hcl
  tfvars = {
    teststring = "iamstring"
    testlist   = ["1", "2", "3"]
    testmap    = { "a" = "1", "b" = "2", "c" = "3" }
  }

  tfvars_sensitive = {
    secret      = "securestring"
    secret_list = ["sec1", "sec2", "sec3"]
    secret_map  = { "x" = "sec4", "y" = "sec5", "z" = "sec6" }
  }
```

#### Environment Variables
`envvars` accepts a map of strings, and `envvars_sensitive` is the same except it will also mark the variable(s) as sensitive upon creation.
```hcl
  envvars = {
    AWS_ACCESS_KEY_ID = "ABCDEFGHIJKLMNOPQRST"
  }

  envvars_sensitive = {
    AWS_SECRET_ACCESS_KEY = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$"
  }
```

### Team Access
To optionally add RBAC to the Workspace, there are two options. 

#### Built-In Permissions
The `team_access` input variable accepts a map of strings whereby each key/value pair is the existing Team name and built-in permission level.

```hcl
  team_access = {
    "dev-team"     = "read"
    "release-team" = "write"
    "ops-team"     = "admin"
  }
```

#### Custom Permissions
The `custom_team_access` input variable accepts a map of objects whereby each object represents a set of custom team permission levels. The object key is the existing Team name.  The way the TFE provider and API currently work, all five of the object attributes must be specified together when using.

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
To optionally create notifications, the `notifications` input variable accepts a list of objects, whereby each object is a notification configuration.

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