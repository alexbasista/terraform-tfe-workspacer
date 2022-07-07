terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = ">= 0.32.1"
    }
  }

  experiments = [module_variable_optional_attrs]
}