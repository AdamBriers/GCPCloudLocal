# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
#locals {
#}

terraform {
  source = "../../../../modules//vpn_classic/"
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

  project_id      = dependency.project.outputs.project_id
  gateway_name    = "gc-a-vpnazure-0001"
  ip_name         = "gc-a-ipvpnazure-0001"
  network         = dependency.prd_vpc.outputs.network_name
  region          = "europe-west2"
  #tunnel_count       = 2
  #peer_ips           = []
  route_priority = 1000
  #local_traffic_selector  = ["172.26.64.0/18", "172.26.0.0/18", "199.36.153.4/30" ]

}