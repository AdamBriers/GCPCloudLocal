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

dependency "router" {
  config_path = "../../vpn/on_prem"
}

dependency "prd_vpc" {
  config_path = "../../vpc_shared_prd"
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {

project_id         = dependency.vpc_host_project.outputs.project_id
  router_name      = dependency.router.outputs.router_name
  name             = "gc-p-nat-0001"
  network_selflink = dependency.prd_vpc.outputs.network_name

}
