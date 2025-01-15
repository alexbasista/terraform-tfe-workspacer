provider "tfe" {
  hostname = "app.terraform.io"
}

module "workspacer" {
  source  = "alexbasista/workspacer/tfe"
  
  count   = 8

  organization   = "<my-org-name>"
  workspace_name = "workspacer-count-ex-${count.index}"
  workspace_tags = ["app:acme", "env:test", "cloud:aws"]
  project_name   = "Default Project"
}