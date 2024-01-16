
# WARNING: Generated module tests should be considered experimental and be reviewed by the module author.

run "notification_configuration" {
  assert {
    condition     = tfe_notification_configuration.nc.workspace_id == tfe_workspace.ws.id
    error_message = "incorrect workspace id"
  }
}

# outputs_test.tftest.hcl
# WARNING: Generated module tests should be considered experimental and be reviewed by the module author.

run "workspace_id_output" {
  assert {
    condition     = output.workspace_id == tfe_workspace.ws.id
    error_message = "incorrect workspace id"
  }
}

# policy_sets_test.tftest.hcl
# WARNING: Generated module tests should be considered experimental and be reviewed by the module author.

run "policy_set" {
  assert {
    condition     = tfe_workspace_policy_set.ps.workspace_id == tfe_workspace.ws.id
    error_message = "incorrect workspace id"
  }
}

# project_test.tftest.hcl
# WARNING: Generated module tests should be considered experimental and be reviewed by the module author.

run "project" {
  assert {
    condition     = data.tfe_project.ws.organization == var.organization
    error_message = "incorrect organization"
  }
}

# run_triggers_test.tftest.hcl
# WARNING: Generated module tests should be considered experimental and be reviewed by the module author.

run "run_trigger" {
  assert {
    condition     = tfe_run_trigger.rt.workspace_id == tfe_workspace.ws.id
    error_message = "incorrect workspace id"
  }
}

# team_access_test.tftest.hcl
# WARNING: Generated module tests should be considered experimental and be reviewed by the module author.

run "team_access" {
  assert {
    condition     = tfe_team_access.managed.workspace_id == tfe_workspace.ws.id
    error_message = "incorrect workspace id"
  }
}

# variable_sets_test.tftest.hcl
# WARNING: Generated module tests should be considered experimental and be reviewed by the module author.

run "variable_set" {
  assert {
    condition     = tfe_workspace_variable_set.vs.workspace_id == tfe_workspace.ws.id
    error_message = "incorrect workspace id"
  }
}

# workspace_test.tftest.hcl
# WARNING: Generated module tests should be considered experimental and be reviewed by the module author.

run "workspace" {
  assert {
    condition     = tfe_workspace.ws.organization == var.organization
    error_message = "incorrect organization"
  }
}

# workspace_variables_test.tftest.hcl
# WARNING: Generated module tests should be considered experimental and be reviewed by the module author.

run "workspace_variables" {
  assert {
    condition     = tfe_variable.tfvars.workspace_id == tfe_workspace.ws.id
    error_message = "incorrect workspace id"
  }
}

Please note that these tests are generated based on the provided configuration and may not cover all possible edge cases. They should be reviewed and potentially expanded by the module author to ensure comprehensive coverage.