terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.25.3"
    }
  }
  
  experiments = [module_variable_optional_attrs]
}