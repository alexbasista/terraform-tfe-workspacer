# Example - With VCS Providers

## Normal VCS Provider (OAuth)

```hcl
module "workspacer_vcs_oauth_token" {
  source  = "alexbasista/workspacer/tfe"
  version = "0.11.0"

  organization   = "<my-org-name>"
  workspace_name = "workspacer-vcs-oauth-ex"
  workspace_tags = ["env:test", "app:acme"]
  project_name   = "Default Project"

  working_directory     = "</example/tf/directory>"
  auto_apply            = true
  file_triggers_enabled = true
  trigger_patterns      = ["</example/tf/directory/**/*>"]
  queue_all_runs        = true

  vcs_repo = {
    identifier         = "<vcs-organization>/<terraform-repo-name>"
    branch             = "main"
    oauth_token_id     = "<ot-abcdefg123456789>"
    ingress_submodules = false
    tags_regex         = null
  }
}
```

## GitHub App
```hcl
module "workspacer_vcs_github_app" {
  source  = "alexbasista/workspacer/tfe"
  version = "0.11.0"

  organization   = "<my-org-name>"
  workspace_name = "workspacer-vcs-github-app-ex"
  workspace_tags = ["env:test", "app:acme"]
  project_name   = "Default Project"

  working_directory     = "</example/tf/directory>"
  auto_apply            = false
  file_triggers_enabled = true
  trigger_patterns      = ["</example/tf/directory/**/*>"]
  queue_all_runs        = true

  vcs_repo = {
    identifier                 = "<vcs-organization>/<terraform-repo-name>"
    branch                     = "main"
    github_app_installation_id = "<ghain-abcdefg123456789>"
    ingress_submodules         = false
    tags_regex                 = null
  }
}
```
