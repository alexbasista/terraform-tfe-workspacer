terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = ">= 0.31.0"
    }
  }
  
  experiments = [module_variable_optional_attrs]
}