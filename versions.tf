terraform {
  required_version = ">= 1.4.4"

  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "~> 0.65"
    }
  }
}