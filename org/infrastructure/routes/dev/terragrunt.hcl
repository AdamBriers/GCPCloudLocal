# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
#locals {
#}

terraform {
  source = "../../../../modules//routes/"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders("org.hcl")
}

dependency "vpc_shared_dev" {
  config_path = "../../vpc_shared_dev"

  # Configure mock outputs for the terraform commands that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
  mock_outputs = {
    network_name = "network-not-created-yet"
  }
}


dependency "vpc_host_project" {
  config_path = "../../vpc_host_project"

  # Configure mock outputs for the terraform commands that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
  mock_outputs = {
    project_id = "project-not-created-yet"
  }
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {

  project_id   = dependency.vpc_host_project.outputs.project_id
  network_name = dependency.vpc_shared_dev.outputs.network_name
  routes = [
    {
      name                   = "gc-t-rt-0001"
      description            = "Route through to the internet"
      destination_range      = "0.0.0.0/0"
      tags                   = "" # List of Network tags assigned to this route. Empty list means all instances can use it.
      next_hop_internet      = "true"
      priority               = 1000
      next_hop_ip            = null
      next_hop_instance      = null
      next_hop_instance_zone = null
      next_hop_vpn_tunnel    = null
    },
  ]
}