provider "tfe" {
  hostname = var.tfe_hostname
}

module "workspacer_oauth_token" {
  source = "../.."

  organization   = var.organization
  workspace_name = "workspacer-vcs-oauth-ex"
  workspace_tags = ["env:test", "app:acme"]
  project_name   = "Default Project" 

  working_directory     = "/examples/with-vcs/tf-working-dir-test"
  auto_apply            = true
  file_triggers_enabled = true
  trigger_patterns      = ["/examples/with-vcs/tf-working-dir-test/**/*"]
  queue_all_runs        = true

  vcs_repo = {
    identifier         = "alexbasista/terraform-tfe-workspacer"
    branch             = "main"
    oauth_token_id     = var.oauth_token_id
    ingress_submodules = false
    tags_regex         = null
  }
}

module "workspacer_github_app" {
  source = "../.."

  organization   = var.organization
  workspace_name = "workspacer-vcs-github-app-ex"
  workspace_tags = ["env:test", "app:acme"]
  project_name   = "Default Project" 

  working_directory     = "/examples/with-vcs/tf-working-dir-test"
  auto_apply            = true
  file_triggers_enabled = true
  trigger_patterns      = ["/examples/with-vcs/tf-working-dir-test/**/*"]
  queue_all_runs        = true

  vcs_repo = {
    identifier                 = "alexbasista/terraform-tfe-workspacer"
    branch                     = "main"
    github_app_installation_id = var.github_app_installation_id
    ingress_submodules         = false
    tags_regex                 = null
  }
}