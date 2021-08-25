# resource "random_pet" "teststring" {
#     length    = 2
#     prefix    = var.teststring
#     separator = "-"
# }

# resource "random_pet" "secstring" {
#     length    = 2
#     prefix    = var.secretstring
#     separator = "/"
# }

# resource "random_shuffle" "testlist" {
#     input = [
#         for i in var.testlist:
#         upper(i)
#     ]
# }

# resource "random_shuffle" "seclist" {
#     input = [
#         for i in var.secretlist:
#         upper(i)
#     ]
# }

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