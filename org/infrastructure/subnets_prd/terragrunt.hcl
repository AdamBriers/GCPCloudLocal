# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
#locals {
#}

terraform {
  source = "../../../modules//subnet/"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders("org.hcl")
}

dependency "vpc_shared_prd" {
  config_path = "../vpc_shared_prd"

  # Configure mock outputs for the terraform commands that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
  mock_outputs = {
    network_name = "network-not-created-yet"
  }
}

dependency "vpc_host_project" {
  config_path = "../vpc_host_project"

  # Configure mock outputs for the terraform commands that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
  mock_outputs = {
    project_id = "project-not-created-yet"
  }
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {

  vpc_network_name = dependency.vpc_shared_prd.outputs.network_name
  project_id       = dependency.vpc_host_project.outputs.project_id

  subnets = [
    {
      sub_network_name         = "gc-a-snet-infra-0001"
      sub_network_description  = "Sub network 1 for the Production Infrastructure environment"
      ip_cidr_range            = "172.26.0.0/24" # Usable 254 Ip's: 172.26.0.1 - 172.26.0.254
      region                   = "europe-west2"
      private_ip_google_access = true
    },
    {
      sub_network_name         = "gc-p-snet-dmz-0001"
      sub_network_description  = "Sub network 1 for the Production DMZ environment"
      ip_cidr_range            = "172.26.4.0/24" # Usable 254 Ip's: 172.26.4.1 - 172.26.4.254
      region                   = "europe-west2"
      private_ip_google_access = true
    },
    {
      sub_network_name         = "gc-p-snet-backend-0001"
      sub_network_description  = "Sub network 1 for the Production Backend environment"
      ip_cidr_range            = "172.26.48.0/23" # Usable 510 Ip's: 172.26.48.1 - 172.26.49.254
      region                   = "europe-west2"
      private_ip_google_access = true
    },
    {
      sub_network_name         = "gc-p-snet-middleware-0001"
      sub_network_description  = "Sub network 1 for the Production Middleware environment"
      ip_cidr_range            = "172.26.16.0/22" # Usable 1022 Ip's: 172.26.16.1 - 172.26.19.254
      region                   = "europe-west2"
      private_ip_google_access = true
    },
  ]
}