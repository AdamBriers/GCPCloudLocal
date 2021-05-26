terraform {
  source = "../../../../modules//gcs_bucket/"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders("org.hcl")
}

dependency "project" {
  config_path = "../project"

  # Configure mock outputs for the terraform commands that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
  mock_outputs = {
    project_id = "project-not-created-yet"
  }
}

inputs = {

  project_id    = dependency.project.outputs.project_id
  location      = "europe-west2"
  name          = "backup_of_bq_zipfiles"
  storage_class = "REGIONAL"
}

