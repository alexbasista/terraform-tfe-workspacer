# Workspacer

Terraform module to create, configure, and manage Workspaces in HCP Terraform or Terraform Enterprise.

## Usage

```hcl
module "workspacer" {
  source  = "alexbasista/workspacer/tfe"
  

  organization   = "my-hcptf-or-tfe-org-name"
  workspace_name = "my-new-ws"
  workspace_desc = "Description of my new Workspace."
  workspace_tags = ["tag1", "tag2", "tagz"]
  project_name   = "Default Project"

  tfvars = {
    teststring = "iamstring"
    testlist   = ["1", "2", "3"]
    testmap    = { "a" = "1", "b" = "2", "c" = "3" }
  }
}
```
>📝 Note: Setting a `TFE_TOKEN` environment variable is the recommended approach for the TFE provider authentication.

See the [examples](./examples) directory for more detailed example scenarios, and see the following section for optional configurations/features.

## Configuration Options

### Projects

To place the Workspace into an existing Project, set the input variable `project_name`.

```hcl
project_name = "my-project"
```

### With VCS

The optional `vcs_repo` input variable expects a map of key/value pairs with up to six attributes.


#### Using an OAuth Token

```hcl
  vcs_repo = {
    identifier     = "<VCS organization>/<VCS repository name>"
    branch         = "main"
    oauth_token_id = "ot-abcdefg123456789"
  }
```

#### Using a GitHub App Installation ID

```hcl
  vcs_repo = {
    identifier                 = "<VCS organization>/<VCS repository name>"
    branch                     = "main"
    github_app_installation_id = "ghain-abcdefg123456789"
  }
```

### Workspace Variables

This module strives to make creating Workspace Variables more streamlined, and closer to the look and feel of using a `terraform.tfvars` file (key/value pairs) when creating them. There are four different optional input variables available for creating Workspace Variables:

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
    "example-team-1" = "read"
    "example-team-2" = "write"
    "example-team-3" = "admin"
  }
```

#### Custom Permissions

The `custom_team_access` input variable accepts a map of objects whereby each object represents a set of custom team permission levels. The object key is the (existing) Team name. The way the TFE provider and API currently work, all five of the object attributes must be specified together when using.

```hcl
  custom_team_access = {
    "example-team-1" = {
      runs              = "read"
      variables         = "read"
      state_versions    = "read"
      sentinel_mocks    = "none"
      workspace_locking = false
      run_tasks         = false
    }
    "example-team-2" = {
      runs              = "plan"
      variables         = "write"
      state_versions    = "read-outputs"
      sentinel_mocks    = "read"
      workspace_locking = true
      run_tasks         = true
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
```

### Run Triggers

To add Run Triggers, the `run_trigger_source_workspaces` input variable accepts a list of (existing) Workspace names.

```hcl
  run_trigger_source_workspaces = [
    "example-src-workspace-1",
    "example-src-workspace-2"
  ]
```

### Variable Sets

To add the Workspace into one or more already existing Variable Sets, the input variable `variable_set_names` accepts a list of Variable Set names.

```hcl
  variable_set_names = [
    "example-varset-1",
    "example-varset-2"
  ]
```

### Policy Sets

To add the Workspace into one or more already existing Policy Sets, the input variable `policy_set_names` accepts a list of Policy Set names.

```hcl
  policy_set_names = [
    "example-sentinel-global",
    "example-sentinel-prod"
  ]
```

### SSH Key ID

To configure an SSH key on your Workspace, set the SSH key ID via the input `ssh_key_id`. This value should NOT be the name of the SSH key as it appears in the HCP Terraform or TFE UI. If you do not have the ID of your SSH key, you can extract it using the command below. **Note:** This key is only used when a workspace needs to access a private git repository to pull in a module from a git-based module URL or git submodule.

```sh
$ curl  --header "Authorization: Bearer $TFE_TOKEN \
               https://app.terraform.io/api/v2/organizations/myorg/ssh-keys 

{"data":[{"id":"sshkey-abcdefgh12345678","type":"ssh-keys","attributes":{"name":"my-github-ssh-key"},"links":{"self":"/api/v2/ssh-keys/sshkey-abcdefgh12345678"}}]}⏎  
```

---

## Caveats/Limitations
- Due to some current provider-interfacing/API challenges with Workspace Variables, any non-string Workspace Variable value (where the `hcl` attribute would equal `true`) will be JSON-encoded and subsequently any `:` characters will be replaced with `=`. Therefore, _non-string_ Workspace Variable values that contain a colon character are not currently supported.

---

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9 |
| <a name="requirement_tfe"></a> [tfe](#requirement\_tfe) | ~> 0.62 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_tfe"></a> [tfe](#provider\_tfe) | ~> 0.62 |

## Resources

| Name | Type |
|------|------|
| [tfe_notification_configuration.nc](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/notification_configuration) | resource |
| [tfe_run_trigger.rt](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/run_trigger) | resource |
| [tfe_team_access.custom](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team_access) | resource |
| [tfe_team_access.managed](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/team_access) | resource |
| [tfe_variable.envvars](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.envvars_ignore_changes](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.envvars_sensitive](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.tfvars](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.tfvars_ignore_changes](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_variable.tfvars_sensitive](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/variable) | resource |
| [tfe_workspace.ws](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace) | resource |
| [tfe_workspace_policy_set.ps](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace_policy_set) | resource |
| [tfe_workspace_settings.ws](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace_settings) | resource |
| [tfe_workspace_variable_set.vs](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/resources/workspace_variable_set) | resource |
| [tfe_policy_set.ps](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/policy_set) | data source |
| [tfe_project.ws](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/project) | data source |
| [tfe_team.custom](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/team) | data source |
| [tfe_team.managed](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/team) | data source |
| [tfe_variable_set.vs](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/variable_set) | data source |
| [tfe_workspace_ids.run_triggers](https://registry.terraform.io/providers/hashicorp/tfe/latest/docs/data-sources/workspace_ids) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_organization"></a> [organization](#input\_organization) | Name of Organization to create Workspace in. | `string` | n/a | yes |
| <a name="input_workspace_name"></a> [workspace\_name](#input\_workspace\_name) | Name of Workspace to create. | `string` | n/a | yes |
| <a name="input_agent_pool_id"></a> [agent\_pool\_id](#input\_agent\_pool\_id) | ID of existing Agent Pool to assign to Workspace. Only valid when `execution_mode` is set to `agent`. | `string` | `null` | no |
| <a name="input_allow_destroy_plan"></a> [allow\_destroy\_plan](#input\_allow\_destroy\_plan) | Boolean setting to allow destroy plans on Workspace. | `bool` | `true` | no |
| <a name="input_assessments_enabled"></a> [assessments\_enabled](#input\_assessments\_enabled) | Boolean to enable Health Assessments such as Drift Detection on Workspace. | `bool` | `false` | no |
| <a name="input_auto_apply"></a> [auto\_apply](#input\_auto\_apply) | Boolean to automatically run a Terraform apply after a successful Terraform plan. | `bool` | `false` | no |
| <a name="input_custom_team_access"></a> [custom\_team\_access](#input\_custom\_team\_access) | Map of existing Team(s) and custom permissions to grant on Workspace. If used, all keys in the object must be specified. | <pre>map(<br/>    object(<br/>      {<br/>        runs              = string<br/>        variables         = string<br/>        state_versions    = string<br/>        sentinel_mocks    = string<br/>        workspace_locking = bool<br/>        run_tasks         = bool<br/>      }<br/>    )<br/>  )</pre> | `{}` | no |
| <a name="input_envvars"></a> [envvars](#input\_envvars) | Map of Environment variables to add to Workspace. | `map(string)` | `{}` | no |
| <a name="input_envvars_ignore_changes"></a> [envvars\_ignore\_changes](#input\_envvars\_ignore\_changes) | Map of sensitive Environment variables to add to Workspace whereby changes made outside of Terraform will be ignored. | `map(string)` | `{}` | no |
| <a name="input_envvars_sensitive"></a> [envvars\_sensitive](#input\_envvars\_sensitive) | Map of sensitive Environment variables to add to Workspace. | `map(string)` | `{}` | no |
| <a name="input_execution_mode"></a> [execution\_mode](#input\_execution\_mode) | Execution mode of Workspace. Valid values are `remote`, `local`, or `agent`. | `string` | `null` | no |
| <a name="input_file_triggers_enabled"></a> [file\_triggers\_enabled](#input\_file\_triggers\_enabled) | Boolean to filter Runs triggered via webhook (VCS push) based on `working_directory` and `trigger_prefixes`. | `bool` | `true` | no |
| <a name="input_force_delete"></a> [force\_delete](#input\_force\_delete) | Boolean to allow deletion of the Workspace if there is a Terraform state that contains resources. | `bool` | `null` | no |
| <a name="input_global_remote_state"></a> [global\_remote\_state](#input\_global\_remote\_state) | Boolean to allow all Workspaces within the Organization to remotely access the State of this Workspace. | `bool` | `false` | no |
| <a name="input_notifications"></a> [notifications](#input\_notifications) | List of Notification objects to configure on Workspace. | <pre>list(<br/>    object(<br/>      {<br/>        name             = string<br/>        destination_type = string<br/>        url              = optional(string)<br/>        token            = optional(string)<br/>        email_addresses  = optional(list(string))<br/>        email_user_ids   = optional(list(string))<br/>        triggers         = list(string)<br/>        enabled          = bool<br/>      }<br/>    )<br/>  )</pre> | `[]` | no |
| <a name="input_policy_set_names"></a> [policy\_set\_names](#input\_policy\_set\_names) | List of names of existing Policy Sets to add this Workspace into. | `list(string)` | `[]` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of existing Project to create Workspace in. | `string` | `null` | no |
| <a name="input_queue_all_runs"></a> [queue\_all\_runs](#input\_queue\_all\_runs) | Boolean setting for Workspace to automatically queue all Runs after creation. | `bool` | `true` | no |
| <a name="input_remote_state_consumer_ids"></a> [remote\_state\_consumer\_ids](#input\_remote\_state\_consumer\_ids) | List of existing Workspace IDs allowed to remotely access the State of Workspace. | `list(string)` | `null` | no |
| <a name="input_run_trigger_source_workspaces"></a> [run\_trigger\_source\_workspaces](#input\_run\_trigger\_source\_workspaces) | List of existing Workspace names that will trigger runs on Workspace. | `list(string)` | `[]` | no |
| <a name="input_speculative_enabled"></a> [speculative\_enabled](#input\_speculative\_enabled) | Boolean to allow Speculative Plans on Workspace. | `bool` | `true` | no |
| <a name="input_ssh_key_id"></a> [ssh\_key\_id](#input\_ssh\_key\_id) | SSH private key the Workspace will use for downloading Terraform modules from Git-based module sources. Key must exist in Organization first. | `string` | `null` | no |
| <a name="input_structured_run_output_enabled"></a> [structured\_run\_output\_enabled](#input\_structured\_run\_output\_enabled) | Boolean to enable the advanced Run UI. Set to `false` for the traditional console-based Run output. | `bool` | `true` | no |
| <a name="input_tags_regex"></a> [tags\_regex](#input\_tags\_regex) | A regular expression used to trigger a Run in Workspace for matching Git tags. This option conflicts with `trigger_patterns` and `trigger_prefixes`. Should only set this value if the former is not being used. | `string` | `null` | no |
| <a name="input_team_access"></a> [team\_access](#input\_team\_access) | Map of existing Team(s) and built-in permissions to grant on Workspace. | `map(string)` | `{}` | no |
| <a name="input_terraform_version"></a> [terraform\_version](#input\_terraform\_version) | Version of Terraform to use for this Workspace. | `string` | `null` | no |
| <a name="input_tfvars"></a> [tfvars](#input\_tfvars) | Map of Terraform variables to add to Workspace. | `any` | `{}` | no |
| <a name="input_tfvars_ignore_changes"></a> [tfvars\_ignore\_changes](#input\_tfvars\_ignore\_changes) | Map of Terraform variables to add to Workspace whereby changes made outside of Terraform will be ignored. | `any` | `{}` | no |
| <a name="input_tfvars_sensitive"></a> [tfvars\_sensitive](#input\_tfvars\_sensitive) | Map of sensitive Terraform variables to add to Workspace. | `any` | `{}` | no |
| <a name="input_trigger_patterns"></a> [trigger\_patterns](#input\_trigger\_patterns) | List of glob patterns that describe the files monitored for changes to trigger Runs in Workspace. Mutually exclusive with `trigger_prefixes`. Only available with TFC. | `list(string)` | `null` | no |
| <a name="input_trigger_prefixes"></a> [trigger\_prefixes](#input\_trigger\_prefixes) | List of paths relative to the root of the VCS repo to filter on when `file_triggers_enabled` is `true`. | `list(string)` | `null` | no |
| <a name="input_variable_set_names"></a> [variable\_set\_names](#input\_variable\_set\_names) | List of names of existing Variable Sets to add this Workspace into. | `list(string)` | `[]` | no |
| <a name="input_vcs_repo"></a> [vcs\_repo](#input\_vcs\_repo) | Object containing settings to connect Workspace to a VCS repository. | <pre>object({<br/>    identifier                 = string<br/>    branch                     = optional(string, null)<br/>    oauth_token_id             = optional(string, null)<br/>    github_app_installation_id = optional(string, null)<br/>    ingress_submodules         = optional(bool, false)<br/>    tags_regex                 = optional(string, null)<br/>  })</pre> | `null` | no |
| <a name="input_working_directory"></a> [working\_directory](#input\_working\_directory) | The relative path that Terraform will execute within. Defaults to the root of the repo. | `string` | `null` | no |
| <a name="input_workspace_desc"></a> [workspace\_desc](#input\_workspace\_desc) | Description of Workspace. | `string` | `"Created by 'workspacer' Terraform module."` | no |
| <a name="input_workspace_tags"></a> [workspace\_tags](#input\_workspace\_tags) | List of tag names to apply to Workspace. Tags must only contain letters, numbers, or colons. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_workspace_id"></a> [workspace\_id](#output\_workspace\_id) | ID of Workspace. |
<!-- END_TF_DOCS -->
