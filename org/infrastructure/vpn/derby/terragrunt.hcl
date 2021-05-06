# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
#locals {
#}

terraform {
  source = "../../../../modules//vpn_ha/"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders("org.hcl")
}

dependency "edge_vpc" {
  config_path = "../../vpc_shared_edge"
  
  # Configure mock outputs for the terraform commands that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
  mock_outputs = {
    network_name = "network-not-created-yet"
  }
}

dependency "project" {
  config_path = "../../vpc_host_project"
}

dependency "router" {
  config_path = "../on_prem"

  # Configure mock outputs for the terraform commands that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
  mock_outputs = {
    router_name = "router-not-created-yet"
  }
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {

  project_id = dependency.project.outputs.project_id
  name       = "gc-a-vpn-derby-0001"
  secret_id  = "gc-a-sct-derby-0001"
  network    = dependency.edge_vpc.outputs.network_name
  router_name = dependency.router.outputs.router_name
  peer_external_gateway = {
    redundancy_type = "SINGLE_IP_INTERNALLY_REDUNDANT"
    interfaces = [{
      id         = 0
      ip_address = "109.234.205.83" # on-prem Derby router ip address
    }]
  }
  tunnels = {
    remote-0 = {
      bgp_peer = {
        address = "169.254.7.1"
        asn     = 64520
      }
      bgp_peer_options                = null
      bgp_session_range               = "169.254.7.2/30"
      ike_version                     = 2
      vpn_gateway_interface           = 0
      peer_external_gateway_interface = 0
      shared_secret                   = ""
    }
    remote-1 = {
      bgp_peer = {
        address = "169.254.8.1"
        asn     = 64521
      }
      bgp_peer_options                = null
      bgp_session_range               = "169.254.8.2/30"
      ike_version                     = 2
      vpn_gateway_interface           = 1
      peer_external_gateway_interface = 0
      shared_secret                   = ""
    }
  }
}