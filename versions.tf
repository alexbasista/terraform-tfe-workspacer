terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = ">= 0.36.0"
    }
  }

  experiments = [module_variable_optional_attrs]
}