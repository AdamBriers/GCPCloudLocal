# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
#locals {
#}

terraform {
  source = "../../..//modules/project/"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {

  project_name    = "gc-d-prj-test-0001"
  folder_id       = "Development" ## Dev folder created in infrastructure
  labels          = {
    "application"      = "data_dev_test"
    "businessunit"     = "homes"
    "costcentre"       = "90imp"
    "createdby"        = "appsbroker"
    "department"       = "it"
    "disasterrecovery" = "no"
    "environment"      = "dev"
    "contact"          = "john_foster"
  }
}