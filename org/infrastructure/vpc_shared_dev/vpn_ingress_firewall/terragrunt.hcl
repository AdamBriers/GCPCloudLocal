# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
#locals {
#}

terraform {
  source = "../../../../modules//firewall_rule/"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders("org.hcl")
}

dependency "vpc_host_project" {
  config_path = "../../vpc_host_project"
}

dependency "vpc_network" {
  config_path = "../"
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {

  name         = "gc-t-vpntest-all-ingress"
  project_id   = dependency.vpc_host_project.outputs.project_id
  network_name = dependency.vpc_network.outputs.network_self_link
  description  = "INGRESS firewall for all ports and protocol on-prem and azure VPN to test and dev."
  direction    = "INGRESS"
  source_ranges = ["172.20.0.0/16", "10.0.0.0/8"]
  allow_rules = [
    {
    protocol = "all",
    ports    = []
    }
  ]
}