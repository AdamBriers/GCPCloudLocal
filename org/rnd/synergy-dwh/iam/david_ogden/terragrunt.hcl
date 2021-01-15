# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
#locals {
#}

terraform {
  source = "../../../../../modules//project_iam/"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders("org.hcl")
}

dependency "project" {
  config_path = "../../project"
}

 inputs = {
   project_id             = dependency.project.outputs.project_id
   #project_id              = "gc-r-prj-synergy-0001-1388"
   project_iam_permissions = ["roles/bigquery.dataEditor"]
   member_type             = "user"
   member_name             = "david.ogden@placesforpeople.co.uk"
 }
