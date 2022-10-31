#------------------------------------------------------------------------------
# Provider
#------------------------------------------------------------------------------
variable "tfe_hostname" {
  type        = string
  description = "Hostname of TFC/TFE to use."
}

#------------------------------------------------------------------------------
# Module
#------------------------------------------------------------------------------
variable "organization" {
  type        = string
  description = "Name of Organization to create Workspace(s) in."
}

variable "workspaces" {
  type = map(
    object(
      {
        name        = string
        description = string
        tags        = list(string)
      }
    )
  )
  description = "Map of objects for Workspaces to create."
  default = {
    ws_1 = {
      name        = "module-workspacer-foreach-test-1"
      description = "Workspace 1 created by Terraform Workspacer module."
      tags        = ["dev", "module-ci", "aws"]
    }
    ws_2 = {
      name        = "module-workspacer-foreach-test-2"
      description = "Workspace 2 created by Terraform Workspacer module."
      tags        = ["stage", "module-ci", "aws"]
    }
    ws_3 = {
      name        = "module-workspacer-foreach-test-3"
      description = "Workspace 3 created by Terraform Workspacer module."
      tags        = ["prod", "module-ci", "aws"]
    }
  }
}