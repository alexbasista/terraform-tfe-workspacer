variable "tfe_hostname" {
  type        = string
  description = "Hostname of TFE instance to provision against."
}

variable "oauth_token_id" {
    type      = string
    sensitive = true
}