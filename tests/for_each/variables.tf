#------------------------------------------------------------------------------
# Provider
#------------------------------------------------------------------------------
variable "tfe_hostname" {
  type        = string
  description = "Hostname of TFE instance to provision against."
}

#------------------------------------------------------------------------------
# Module
#------------------------------------------------------------------------------
variable "organization" {
  type        = string
  description = "Name of TFE Organization to create Workspace(s) in."
}

variable "workspaces" {
  type = map(
    object(
      {
        name        = string
        description = string
      }
    )
  )
  description = "Map of Workspace objects to create."
  default = {
    ws_1 = {
      name        = "workspacer-module-foreach-test-1"
      description = "Workspace 1 created by Terraform Workspacer module."
    }
    ws_2 = {
      name        = "workspacer-module-foreach-test-2"
      description = "Workspace 2 created by Terraform Workspacer module."
    }
    ws_3 = {
      name        = "workspacer-module-foreach-test-3"
      description = "Workspace 3 created by Terraform Workspacer module."
    }
  }
}