variable "organization" {
  type        = string
  description = "Organization to create Workspace in."
}

variable "workspace_name" {
  type        = string
  description = "Name of Workspace."
}

variable "workspace_desc" {
  type        = string
  description = "Workspace description."
  default     = "Created by TFE Terraform provider."
}

variable "execution_mode" {
  type        = string
  description = "Execution mode of Workspace. Valid values are `remote`, `local`, `agent`."
  default     = "remote"

  validation {
    condition     = contains(["remote", "local", "agent"], var.execution_mode)
    error_message = "Supported values are `remote`, `local`, `agent`."
  }
}

variable "auto_apply" {
  type        = bool
  description = "Boolean to automatically apply changes when a Terraform Plan is successful."
  default     = false
}

variable "terraform_version" {
  type        = string
  description = "Version of Terraform the Workspace will use."
  default     = null
}

variable "working_directory" {
  type        = string
  description = "The directory that Terraform will execute within."
  default     = null
}

variable "global_remote_state" {
  type        = bool
  description = "Boolean to allow all Workspaces within the Organization to access the Remote State of this Workspace."
  default     = false
}

variable "remote_state_consumer_ids" {
  type        = list(string)
  description = "List of existing Workspace IDs allowed to access the Remote State of this Workspace."
  default     = null
}

variable "ssh_key_id" {
  type        = string
  description = "SSH private key the Workspace will use for downloading Terraform modules from Git-based module sources. Key must exist in Organization first."
  default     = null
}

variable "vcs_repo" {
  type        = map(string)
  description = "Map of settings to connect Workspace to VCS repository."
  default     = {}
}

variable "queue_all_runs" {
  type        = bool
  description = "Boolean setting for Workspace to automatically queue all Runs after creation."
  default     = true
}

variable "file_triggers_enabled" {
  type        = bool
  description = "Boolean to filter Runs triggered via webhook (VCS push) based on `working_directory` and `trigger_prefixes`."
  default     = true
}

variable "speculative_enabled" {
  type        = bool
  description = "Boolean to allow Speculative Plans on the Workspace."
  default     = true
}


