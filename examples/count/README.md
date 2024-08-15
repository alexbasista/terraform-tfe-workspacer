# Example - Using the `count` Meta-Argument

```hcl
module "workspacer" {
  source  = "alexbasista/workspacer/tfe"
  version = "0.11.0"
  count   = 8

  organization   = "<my-org-name>"
  workspace_name = "workspacer-count-ex-${count.index}"
  workspace_tags = ["app:acme", "env:test", "cloud:aws"]
  project_name   = "Default Project"
}
```