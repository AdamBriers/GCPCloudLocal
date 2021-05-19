# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
#locals {
#}

terraform {
  source = "../../../../modules//project/"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders("org.hcl")
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {

  project_name    = "gc-a-prj-ad-0001"
  folder_id          = "261634282566" ## Infrastructure folder id
  is_service_project = true

  services = [
    "iam.googleapis.com",
    "cloudbilling.googleapis.com",
    "billingbudgets.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "serviceusage.googleapis.com",
    "compute.googleapis.com",
    "storage-api.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com"
  ]

  labels = {
    application      = "active_directory"
    businessunit     = "homes"
    costcentre       = "90imt"
    createdby        = "appsbroker"
    department       = "it"
    disasterrecovery = "no"
    environment      = "prd"
    contact          = "technical_services_team"
  }
}