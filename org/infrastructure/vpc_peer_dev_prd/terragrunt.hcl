# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
#locals {
#}

terraform {
  source = "../../../modules//vpc_peering/"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders("org.hcl")
}

dependency "vpc_shared_dev" {
  config_path = "../vpc_shared_dev"
  
  # Configure mock outputs for the terraform commands that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
  mock_outputs = {
    network_self_link = "network-not-created-yet"
  }
}

dependency "vpc_shared_prd" {
  config_path = "../vpc_shared_prd"
  
  # Configure mock outputs for the terraform commands that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
  mock_outputs = {
    network_self_link = "network-not-created-yet"
  }
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {

  name         = "gc-tp-vpcpeer-0001"
  local_network  = dependency.vpc_shared_dev.outputs.network_self_link
  peer_network   = dependency.vpc_shared_prd.outputs.network_self_link
}