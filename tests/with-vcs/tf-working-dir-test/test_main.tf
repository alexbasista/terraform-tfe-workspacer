terraform {
  required_providers {
    null = {
      source = "hashicorp/null"
      version = "3.1.0"
    }
  }
}

resource "null_resource" "test" {
  provisioner "local-exec" {
   command = "echo 'Testing Terraform TFE Workspacer module with VCS.'"
  }
}