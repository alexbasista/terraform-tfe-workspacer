# terraform {
#   required_providers {
#     null = {
#       source  = "hashicorp/null"
#       version = "3.2.0"
#     }
#   }
# }

# resource "null_resource" "test" {
#   provisioner "local-exec" {
#     command = "echo 'Testing Terraform Workspacer module with VCS-driven workflow.'"
#   }
# }

terraform {
  required_providers {
    random = {
      source = "hashicorp/random"
      version = "3.4.3"
    }
  }
}

resource "random_pet" "test" {}