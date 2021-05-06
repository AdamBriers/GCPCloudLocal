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

dependency "vpc_shared_edge" {
  config_path = "../vpc_shared_edge"

  # Configure mock outputs for the terraform commands that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
  mock_outputs = {
    network_self_link = "network-not-created-yet"
  }
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {

  name                                       = "gc-t-testedgepeer-0001"
  name_second                                = "gc-a-edgetestpeer-0001"
  network                                    = dependency.vpc_shared_dev.outputs.network_self_link
  peer_network                               = dependency.vpc_shared_edge.outputs.network_self_link
  export_custom_routes                       = false
  export_custom_routes_second                = true
  import_custom_routes                       = true
  import_custom_routes_second                = false
  export_subnet_routes_with_public_ip        = false
  export_subnet_routes_with_public_ip_second = false
  import_subnet_routes_with_public_ip        = false
  import_subnet_routes_with_public_ip_second = false
}