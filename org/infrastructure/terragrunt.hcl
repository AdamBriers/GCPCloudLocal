# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
#locals {
#}

terraform {
  source = "../..//modules/org-policies/"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders("org.hcl")
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {

# Org level policies
  org_id               = "" ## P4P og ID
  skip_default_network = true
  require_oslogin      = true
  resource_locations   = ["in:europe-locations"]
  svc_acc_key_creation = true
  uniform_bucket       = true
  svc_acc_grants       = true
  vm_external_ip       = true
  create_sink          = true
  bigquery_project     = "cl-dev-logs-8de19" #As indicated in terraform.tfvars inside bootstrap