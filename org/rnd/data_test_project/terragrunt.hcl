# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
#locals {
#}

terraform {
  source = "../../../modules//project/"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders("org.hcl")
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {

  project_name        = "gc-r-prj-datatestproject-0001"
  folder_id           = "706244237673" ## Research and Development folder id
  org_id              = ""

  labels  = {
    application       = "data_test"
    businessunit      = "homes"
    costcentre        = "90imt"
    createdby         = "appsbroker"
    department        = "it"
    disasterrecovery  = "no"
    environment       = "rnd"
    contact           = "appsbroker"
    }
}