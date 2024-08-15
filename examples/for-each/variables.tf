#------------------------------------------------------------------------------
# Provider
#------------------------------------------------------------------------------
variable "tfe_hostname" {
  type        = string
  description = "Hostname of self-hosted TFE instance. Leave as default when using HCP Terraform."
  default     = "app.terraform.io"
}

#------------------------------------------------------------------------------
# Module
#------------------------------------------------------------------------------
variable "organization" {
  type        = string
  description = "Name of Organization to create Workspaces in."
}

variable "workspaces" {
  type = map(
    object(
      {
        name         = string
        description  = optional(string, null)
        tags         = optional(list(string), null)
        project_name = optional(string, null)
        vcs_repo = optional(
          object(
            {
              identifier                 = string
              branch                     = optional(string, null)
              oauth_token_id             = optional(string, null)
              github_app_installation_id = optional(string, null)
              ingress_submodules         = optional(bool, false)
              tags_regex                 = optional(string, null)
            }
          )
        )
      }
    )
  )

  description = "Map of objects for Workspaces to create."
}