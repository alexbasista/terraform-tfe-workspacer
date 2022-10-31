terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.4.3"
    }
  }
}

resource "random_pet" "test_1" {}