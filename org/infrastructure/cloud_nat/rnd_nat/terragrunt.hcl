# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
#locals {
#}

terraform {
  source = "../../../../modules//cloud_nat/"

}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders("org.hcl")
}

dependency "vpc_host_project" {
  config_path = "../../vpc_host_project"
}

dependency "rnd_vpc" {
  config_path = "../../vpc_shared_rnd"
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {

  project_id       = dependency.vpc_host_project.outputs.project_id
  name             = "gc-r-nat-0001"
  network_selflink = dependency.rnd_vpc.outputs.network_name
  router_asn       = 64512

}
