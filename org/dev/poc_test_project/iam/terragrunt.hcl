# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
#locals {
#}

terraform {
  source = "../../../../modules//project_iam/"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders("org.hcl")
}

dependency "project" {
  config_path = "../"

  # Configure mock outputs for the terraform commands that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
  mock_outputs = {
    project_id = "project-not-created-yet"
  }
}

dependency "bo_service_account" {
  config_path = "../service_accounts/business_objects"

  # Configure mock outputs for the terraform commands that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
  mock_outputs = {
    email = "bo-service-account-not-created-yet"
  }
}

dependency "powerbi_service_account" {
  config_path = "../service_accounts/power_bi"

  # Configure mock outputs for the terraform commands that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
  mock_outputs = {
    email = "power-bi-service-account-not-created-yet"
  }
}

dependency "ssis_service_account" {
  config_path = "../service_accounts/ssis"

  # Configure mock outputs for the terraform commands that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
  mock_outputs = {
    email = "ssis-service-account-not-created-yet"
  }
}

dependency "ssrs_service_account" {
  config_path = "../service_accounts/ssrs"

  # Configure mock outputs for the terraform commands that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
  mock_outputs = {
    email = "ssrs-service-account-not-created-yet"
  }
}

inputs = {
  project_id = dependency.project.outputs.project_id

  project_members = [
    {
      project_iam_permissions = ["roles/iap.tunnelResourceAccessor"]
      member_type             = "user"
      member_name             = "ferris.hall@appsbroker.com"
    },
    {
      project_iam_permissions = ["roles/bigquery.admin"]
      member_type             = "user"
      member_name             = "mahendra.navarange@appsbroker.com"
    },
    {
      project_iam_permissions = ["roles/iap.tunnelResourceAccessor"]
      member_type             = "user"
      member_name             = "michael.owen@appsbroker.com"
    },
    {
      project_iam_permissions = ["roles/bigquery.admin"]
      member_type             = "user"
      member_name             = "satyendra.gupta@appsbroker.com"
    },
    {
      project_iam_permissions = ["roles/bigquery.dataViewer", "roles/bigquery.jobUser", "roles/storage.objectViewer"]
      member_type             = "serviceaccount"
      member_name             = dependency.bo_service_account.outputs.email
    },
    {
      project_iam_permissions = ["roles/bigquery.dataViewer", "roles/bigquery.jobUser", "roles/storage.objectViewer"]
      member_type             = "serviceaccount"
      member_name             = dependency.powerbi_service_account.outputs.email
    },
    {
      project_iam_permissions = ["roles/bigquery.dataViewer", "roles/bigquery.jobUser", "roles/storage.objectViewer"]
      member_type             = "serviceaccount"
      member_name             = dependency.ssrs_service_account.outputs.email
    },
    {
      project_iam_permissions = ["roles/bigquery.dataEditor", "roles/bigquery.jobUser", "roles/storage.objectAdmin"]
      member_type             = "serviceaccount"
      member_name             = dependency.ssis_service_account.outputs.email
    },
  ]
}
