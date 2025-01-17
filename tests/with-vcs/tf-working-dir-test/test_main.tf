terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }
  }
}

resource "random_pet" "test_1" {}

resource "random_pet" "test_2" {}