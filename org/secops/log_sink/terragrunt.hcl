# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
#locals {
#}

terraform {
  source = "../../../modules//org_log_sink/"
}
dependency "project" {
  config_path = "../logging_project"
  
  # Configure mock outputs for the terraform commands that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
  mock_outputs = {
    project_id = "project-not-created-yet"
  }
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders("org.hcl")
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  sink_name      = "gc-a-orglogsink-0001"
  project_id     = dependency.project.outputs.project_id
  disabled       = false
  include_filter = "logName=(\"organizations/205038295325/logs/cloudaudit.googleapis.com%2Factivity\" OR \"organizations/205038295325/logs/cloudaudit.googleapis.com%2Fdata_access\" OR \"organizations/205038295325/logs/cloudaudit.googleapis.com%2Fsystem_event\")"
  }
