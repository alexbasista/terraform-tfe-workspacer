variable "tfe_hostname" {
  type        = string
  description = "Hostname of TFE instance to provision against."
}

variable "organization" {
  type        = string
  description = "Name of TFE Organization to provision Workspace(s) in."
  default     = "tfeadmin"
}

variable "workspace_count" {
  type        = number
  description = "Number of Workspaces to provision."
  default     = 25
}

variable "workspace_name_prefix" {
  type        = string
  description = "Workspace naming prefix"
  default     = "ws"
}

variable "workspace_desc" {
  type        = string
  description = "Description of Workspaces."
  default     = "Created by TFE Workspacer module."
}