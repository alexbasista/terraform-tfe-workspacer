data "tfe_project" "ws" {
  count = var.project_name != null ? 1 : 0
  
  name         = var.project_name
  organization = var.organization
}