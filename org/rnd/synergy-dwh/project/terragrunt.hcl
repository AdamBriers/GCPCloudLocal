# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
#locals {
#}

terraform {
  source = "../../../../modules//project/"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders("org.hcl")
}

dependency "folder" {
  config_path = "../../"
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {

  project_name        = "gc-r-prj-synergy-0001"
  folder_id           = dependency.folder.outputs.folder_created ## Research and Development folder id

  labels  = {
    application       = "synergy"
    businessunit      = "homes"
    costcentre        = "90imt"
    createdby         = "appsbroker"
    department        = "it"
    disasterrecovery  = "no"
    environment       = "rnd"
    contact           = "david_fairbrother"
    }
}