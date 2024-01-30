data "tfe_github_app_installation" "github" {
  count           = lookup(var.vcs_repo, "github_app_installation_id", null) != null ? 1 : 0
  installation_id = lookup(var.vcs_repo, "github_app_installation_id", null)
}

resource "tfe_workspace" "ws" {
  organization                  = var.organization
  name                          = var.workspace_name
  description                   = var.workspace_desc
  allow_destroy_plan            = var.allow_destroy_plan
  auto_apply                    = var.auto_apply
  assessments_enabled           = var.assessments_enabled
  file_triggers_enabled         = var.file_triggers_enabled
  global_remote_state           = var.global_remote_state
  remote_state_consumer_ids     = var.remote_state_consumer_ids
  queue_all_runs                = var.queue_all_runs
  speculative_enabled           = var.speculative_enabled
  structured_run_output_enabled = var.structured_run_output_enabled
  ssh_key_id                    = var.ssh_key_id
  tag_names                     = var.workspace_tags
  terraform_version             = var.terraform_version
  trigger_prefixes              = var.trigger_prefixes
  trigger_patterns              = var.trigger_patterns
  working_directory             = var.working_directory
  force_delete                  = var.force_delete
  project_id                    = var.project_name != null ? data.tfe_project.ws[0].id : null

  dynamic "vcs_repo" {
    for_each = lookup(var.vcs_repo, "identifier", null) == null ? [] : [var.vcs_repo]
    content {
      identifier                 = lookup(var.vcs_repo, "identifier", null)
      branch                     = lookup(var.vcs_repo, "branch", null)
      oauth_token_id             = lookup(var.vcs_repo, "oauth_token_id", null) != null ? lookup(var.vcs_repo, "oauth_token_id", null) : null
      github_app_installation_id = lookup(var.vcs_repo, "github_app_installation_id", null) != null ? data.tfe_github_app_installation.github[0].id : null
      ingress_submodules         = lookup(var.vcs_repo, "ingress_submodules", null)
      tags_regex                 = lookup(var.vcs_repo, "tags_regex", null)
    }
  }
}

resource "tfe_workspace_settings" "ws" {
  workspace_id   = tfe_workspace.ws.id
  execution_mode = var.execution_mode
  agent_pool_id  = var.execution_mode == "agent" ? var.agent_pool_id : null
}

