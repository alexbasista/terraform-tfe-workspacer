variable "tfe_hostname" {
  type        = string
  description = "Hostname of TFE instance to provision against."
}

variable "organization" {
  type        = string
  description = "Name of TFE Organization to provision Workspace(s) in."
  default     = "tfeadmin"
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
  description = "Map of Workspace objects to provision."
  default = {
    ws_1 = {
      name        = "ws-1"
      description = "workspace-1"
    }
    ws_2 = {
      name        = "ws-2"
      description = "workspace-2"
    }
    ws_3 = {
      name        = "ws-3"
      description = "workspace-3"
    }
  }
}