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

dependency "prd_vpc" {
  config_path = "../../vpc_shared_prd"
}

dependency "project" {
  config_path = "../../vpc_host_project"
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {

  project_id             = dependency.project.outputs.project_id
  name                   = "gc-a-vpn-onprem-0001"
  network                = dependency.prd_vpc.outputs.network_name
  #peer_external_gateway = {
  #  redundancy_type = "SINGLE_IP_INTERNALLY_REDUNDANT"
  #  interfaces = [{
  #    id         = 0
  #    ip_address = "8.8.8.8" # on-prem router ip address
  #    }]
  #}
  router_asn = 64514
  tunnels = {
    remote-0 = {
      bgp_peer = {
        address = "169.254.1.1"
        asn     = 64600
      }
      bgp_peer_options                = null
      bgp_session_range               = "169.254.1.2/30"
      ike_version                     = 2
      vpn_gateway_interface           = 0
      peer_external_gateway_interface = 0
      shared_secret                   = "VPN@toxxxxxx"
    }
    remote-1 = {
      bgp_peer = {
        address = "169.254.2.1"
        asn     = 64600
      }
      bgp_peer_options                = null
      bgp_session_range               = "169.254.2.2/30"
      ike_version                     = 2
      vpn_gateway_interface           = 1
      peer_external_gateway_interface = 0
      shared_secret                   = "VPN@toxxxxxx"
    }
  }
}