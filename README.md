# terraform-tfe-workspacer
Terraform module to create and configure a Workspace(s) in Terraform Cloud/Enterprise.

## Usage
```hcl
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
  hostname = "my-tfe-instance.com"
}

module "workspacer" {
  source  = "alexbasista/workspacer/tfe"
  version = "0.2.0"

  organization   = "my-tfe-org"
  workspace_name = "my-new-ws"
  workspace_desc = "Description of my new Workspace."
  workspace_tags = ["tag1", "tag2", "tagz"]

  tfvars = {
    teststring = "iamstring"
    testlist   = ["1", "2", "3"]
    testmap    = { "a" = "1", "b" = "2", "c" = "3" }
  }
}
```
> Note: Setting a `TFE_TOKEN` environment variable is the recommended approach for the TFE provider auth.

See the [tests](./tests) directory for more detailed examples/scenarios, and see the below sections for optional configurations/features.

### With VCS
The optional `vcs_repo` input variable expects a map of key/value pairs with up to four attributes (`branch` and `ingress_submodules` are optional).
```hcl
  vcs_repo = {
    identifier         = "<VCS organization>/<VCS repository>"
    branch             = "main"
    oauth_token_id     = "ot-abcdefg123456789"
  }
```

### Workspace Variables
This module strives to make creating Workspace Variables as streamlined as possible and closer to the Terraform OSS `terraform.tfvars` experience of specifying input variable values as key/value pairs. There are four different optional input variables available for creating Workspace Variables:

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
To configure RBAC on the Workspace, there are two options:

#### Built-In Permissions
The `team_access` input variable accepts a map of strings whereby each key/value pair is the (existing) Team name and built-in permission level.

```hcl
  team_access = {
    "dev-team"     = "read"
    "release-team" = "write"
    "ops-team"     = "admin"
  }
```

#### Custom Permissions
The `custom_team_access` input variable accepts a map of objects whereby each object represents a set of custom team permission levels. The object key is the (existing) Team name. The way the TFE provider and API currently work, all five of the object attributes must be specified together when using.

```hcl
  custom_team_access = {
    "app-team" = {
      runs              = "read"
      variables         = "read"
      state_versions    = "read"
      sentinel_mocks    = "none"
      workspace_locking = false
      run_tasks         = "none"
    }
    "security-team" = {
      runs              = "plan"
      variables         = "write"
      state_versions    = "read-outputs"
      sentinel_mocks    = "read"
      workspace_locking = true
      run_tasks         = "read"
    }
  }
```

### Notifications
To create Notifications, the `notifications` input variable accepts a list of objects, whereby each object is a Notification configuration.

```hcl
  notifications = [
    {
      name             = "test-notification-generic"
      destination_type = "generic"
      url              = "http://example.com/receive-notifications-api"
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
      url              = "https://hooks.slack.com/example"
      triggers         = ["run:completed", "run:errored"]
      enabled          = true
    }
  ]
}
```

### Run Triggers
To add Run Triggers, the `run_trigger_source_workspaces` input variable accepts a list of (existing) Workspace names.

```hcl
  run_trigger_source_workspaces = [
    "base-networking-ws",
    "base-iam-ws"
  ]
```
<p>&nbsp;</p>

## Disclaimer
This module currently uses the experimental feature [Optional Object Type Attributes](https://www.terraform.io/docs/language/expressions/type-constraints.html#experimental-optional-object-type-attributes) for the `notifications` input variable, so seeing a warning in the console output when Terraforms runs is expected and normal. Since this feature is expermimental, it is likely that there will be breaking changes when it is released as an officially supported feature in Terraform core. This module will be updated accordingly with a new version when that happens.
> Update: this experiment will be concluded soon with an improved design! The current plan is for this feature to GA with the v1.3.0 release of Terraform.
<p>&nbsp;</p>

## Limitations
- Due to some current provider-interfacing/API challenges with Workspace Variables, any non-string Workspace Variable value (where the `hcl` attribute would equal `true`) will be JSON-encoded and subsequently any `:` characters will be replaced with `=`. Therefore, _non-string_ Workspace Variable values that contain a colon character are not currently supported.