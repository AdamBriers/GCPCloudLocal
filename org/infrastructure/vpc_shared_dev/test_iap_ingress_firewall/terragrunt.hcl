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

  name         = "iap-ingress-compute-testanddevenvironment"
  project_id   = dependency.vpc_host_project.outputs.project_id
  network_name = dependency.vpc_network.outputs.network_self_link
  description  = "For TEST Purposes ONLY - INGRESS firewall for SSH (TCP port 22) using 'IAP for TCP forwarding' to test and dev environment."
  direction    = "INGRESS"
  source_ranges = ["35.235.240.0/20"]
  allow_rules = [
    {
    protocol = "TCP",
    ports    = [22]
    }
  ]
}