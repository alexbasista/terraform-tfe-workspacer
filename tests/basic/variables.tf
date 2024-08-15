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
  description = "Name of Organization to create Workspace in."
}