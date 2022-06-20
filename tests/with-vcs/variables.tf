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
  description = "Name of TFE Organization to provision Workspace(s) in."
}

variable "oauth_token_id" {
  type      = string
  sensitive = true
}