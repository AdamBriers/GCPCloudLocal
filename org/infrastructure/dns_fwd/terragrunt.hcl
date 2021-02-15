# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
#locals {
#}

terraform {
  source = "../../../modules//gcp_cloud_dns_fwd_zone/"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders("org.hcl")
}

dependency "vpc_host_project" {
  config_path = "../vpc_host_project"
}

dependency "vpc_shared_prd" {
  config_path = "../vpc_shared_prd"
}
dependency "vpc_shared_dev" {
  config_path = "../vpc_shared_dev"
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {

  project_id                         = dependency.vpc_host_project.outputs.project_id
  private_visibility_config_networks = ["${dependency.vpc_shared_prd.outputs.network_self_link}", "${dependency.vpc_shared_dev.outputs.network_self_link}"]
  description                        = "DNS Zone to forward requests to placesforpeople nameservers"
  name                               = "dns-google-fwd"                     
  dns_name                           = "group.net."
  target_name_server_addresses       = ["10.9.10.1", "10.9.10.2"]
}