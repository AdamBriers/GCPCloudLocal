terraform {
  source = "../../../../../modules//compute_instance_static_ip/"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders("org.hcl")
}

dependency "project" {
  config_path = "../../project"

  # Configure mock outputs for the terraform commands that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
  mock_outputs = {
    project_id = "project-not-created-yet"
  }
}

dependency "service_account" {
  config_path = "../../service_accounts/centro_local"

  # Configure mock outputs for the terraform commands that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
  mock_outputs = {
    email = "service_account-not-created-yet"
  }
}

inputs = {

  gcp_instance_sa_email = dependency.service_account.outputs.email
  instance_name         = "gc-a-vm-dom-derby-0002b"
  network               = "projects/gc-a-prj-vpchost-0001-3312/global/networks/gc-p-vpc-0001"
  subnetwork            = "projects/gc-a-prj-vpchost-0001-3312/regions/europe-west2/subnetworks/gc-a-snet-infra-0001"
  zone                  = "europe-west2-b"
  project               = dependency.project.outputs.project_id
  os_image              = "windows-server-2012-r2-dc-v20210413"
  machine_type          = "n1-standard-1"
  boot_disk_size        = 20
  instance_scope        = ["cloud-platform"]

  ip_address_region     = "europe-west2"
  ip_address_type       = "INTERNAL"
}