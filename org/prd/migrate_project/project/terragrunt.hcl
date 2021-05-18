terraform {
  source = "../../../../modules//project/"
}

include {
  path = find_in_parent_folders("org.hcl")
}

dependency "folder" {
  config_path = "../../"

  # Configure mock outputs for the terraform commands that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
  mock_outputs = {
    folder_id = "folder-not-created-yet"
  }
}

inputs = {

  project_name       = "gc-p-prj-migrate-0001"
  folder_id          = dependency.folder.outputs.folder_created ## Test and Development folder id
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
    contact          = "appsbroker"
  }
}