terraform {
  required_version = ">= 1.9"

  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.58"
    }
  }
}