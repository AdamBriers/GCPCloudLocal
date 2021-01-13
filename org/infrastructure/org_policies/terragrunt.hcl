# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
#locals {
#}

terraform {
  source = "../../../modules//org-policies/"

}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders("org.hcl")
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {

  skip_default_network = true
  require_oslogin      = true
  resource_locations   = ["in:europe-locations"]
  uniform_bucket       = true
  vm_external_ip       = true
  allowed_domain_ids   = ["C04d5nvbw", "C02l4xnhr"] ## C04d5nvbw placesforpeople.co.uk C02l4xnhr appsbroker.com
}
