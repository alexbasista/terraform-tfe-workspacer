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
}