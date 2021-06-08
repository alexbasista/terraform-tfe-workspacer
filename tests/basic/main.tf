terraform {
  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      version = "0.25.3"
    }
  }
}

module "tfe-workspace" {
  source = "../.."

  organization   = "terraform-tom"
  workspace_name = "ws-mod-dev-test-1"
  workspace_desc = "Developing new Terraform module."

  tfvars = {
      instance_size   = "t2.micro"
      cidr_range_list = ["1", "2", "3"]
      testmap         = { "a" = "1", "b" = "2"}
  }

  tfvars_sensitive = {
      secret      = "secret2"
      secret_list = ["one", "two", "three"]
      secret_map  = {"x" = "4", "y" = "5", "z" = "6"}
  }

  envvars = {
      AWS_ACCESS_KEY_ID = "abcdefghijklmnop"
  }

  envvars_sensitive = {
      AWS_SECRET_ACCESS_KEY = "123456789"
  }
}