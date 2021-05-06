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
    project_id = "network-not-created-yet"
  }
}

dependency "project" {
  config_path = "../../vpc_host_project"
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {

  project_id = dependency.project.outputs.project_id
  name       = "gc-a-vpn-onprem-0001"
  secret_id  = "gc-a-sct-onprem-0001"
  network    = dependency.edge_vpc.outputs.network_name
  peer_external_gateway = {
    redundancy_type = "SINGLE_IP_INTERNALLY_REDUNDANT"
    interfaces = [{
      id         = 0
      ip_address = "62.7.75.210" # on-prem router ip address
    }]
  }
  router_advertise_config = {
    groups = []
    mode   = "CUSTOM"
    ip_ranges = {
      # Prod
      "172.26.0.0/24"   = "gc-p-snet-infra-0001"
      "172.26.4.0/24"   = "gc-p-snet-dmz-001"
      "172.26.16.0/22"  = "gc-p-snet-middleware-001"
      "172.26.48.0/23"  = "gc-p-snet-backend-001"
      # Test and Dev
      "172.26.64.0/24"  = "gc-t-snet-infra-0001"
      "172.26.68.0/24"  = "gc-t-snet-dmz-001"
      "172.26.80.0/22"  = "gc-t-snet-middleware-001"
      "172.26.112.0/23" = "gc-t-snet-backend-001"
      # RnD
      "172.26.128.0/24" = "gc-r-snet-infra-0001"
      "172.26.132.0/24" = "gc-r-snet-dmz-001"
      "172.26.144.0/22" = "gc-r-snet-middleware-001"
      "172.26.176.0/23" = "gc-r-snet-backend-001"
      # Google restricted
      "199.36.153.4/30" = "google restricted api range"
    }
  }
  router_asn = 64515
  tunnels = {
    remote-0 = {
      bgp_peer = {
        address = "169.254.1.1"
        asn     = 64514
      }
      bgp_peer_options                = null
      bgp_session_range               = "169.254.1.2/30"
      ike_version                     = 2
      vpn_gateway_interface           = 0
      peer_external_gateway_interface = 0
      shared_secret                   = ""
    }
    remote-1 = {
      bgp_peer = {
        address = "169.254.2.1"
        asn     = 64514
      }
      bgp_peer_options                = null
      bgp_session_range               = "169.254.2.2/30"
      ike_version                     = 2
      vpn_gateway_interface           = 1
      peer_external_gateway_interface = 0
      shared_secret                   = ""
    }
  }
}