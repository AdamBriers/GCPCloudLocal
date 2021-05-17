# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
#locals {
#}

terraform {
  source = "../../../../../modules//org-permissions/"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders("org.hcl")
}

dependency "service_account" {
  config_path = "../../service_accounts/migration-manager"

  # Configure mock outputs for the terraform commands that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
  mock_outputs = {
    email = "service-account-not-created-yet"
  }
}

inputs = {
  org_iam_permissions   = [
    "roles/cloudmigration.inframanager",
    "roles/iam.serviceAccountUser"
  ]
  member_name = dependency.service_account.outputs.email
  member_type = "serviceaccount"
}