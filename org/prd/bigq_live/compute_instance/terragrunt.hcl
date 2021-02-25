terraform {
  source = "../../../../modules//compute_instance/"
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

dependency "service_account" {
  config_path = "../service_accounts/compute"

  # Configure mock outputs for the terraform commands that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
  mock_outputs = {
    email = "service_account-not-created-yet"
  }
}

inputs = {

  gcp_instance_sa_email = dependency.service_account.outputs.email
  instance_name         = "gc-p-vm-bigqlive-0001"
  network               = "projects/gc-a-prj-vpchost-0001-3312/global/networks/gc-p-vpc-0001"
  subnetwork            = "projects/gc-a-prj-vpchost-0001-3312/regions/europe-west2/subnetworks/gc-p-snet-0001"
  project               =  dependency.project.outputs.project_id
  os_image              = "ubuntu-1604-xenial-v20210224"
  machine_type          = "n1-standard-2"
  instance_scope        = ["cloud-platform"]

}