terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
      version = "3.1.1"
    }
  }
}

resource "null_resource" "test" {
  provisioner "local-exec" {
    command = "echo 'Testing Terraform Workspacer module with VCS-driven workflow.'"
  }
}