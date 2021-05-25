terraform {
  source = "../../../../modules//project/"
}

include {
  path = find_in_parent_folders("org.hcl")
}

inputs = {
  project_name       = "gc-p-prj-migrate-0001"
  folder_id          = "folders/261634282566" # Infrastructure folder id
  is_service_project = true
  # host_project_id - Taken from the hard coded value in the 'org/org.tfvars' file
  services = [
    # Default values from project module
    "iam.googleapis.com",
    "cloudbilling.googleapis.com",
    "billingbudgets.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "serviceusage.googleapis.com",
    "compute.googleapis.com",
    "container.googleapis.com",
    "storage-api.googleapis.com",
    "bigquery.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com",

    # Additional services required by Migrate 5.0
    "vmmigration.googleapis.com",
    "servicemanagement.googleapis.com",
    "servicecontrol.googleapis.com"
    # iam.googleapis.com cloudresourcemanager.googleapis.com compute.googleapis.com
  ]

  labels = {
    application      = "migrate"
    businessunit     = "homes"
    costcentre       = "90imt"
    createdby        = "appsbroker"
    department       = "it"
    disasterrecovery = "no"
    environment      = "prd"
    contact          = "technical_services_team"
  }
}