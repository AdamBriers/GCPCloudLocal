# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
#locals {
#}

terraform {
  source = "../../../../modules//org-permissions/"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders("org.hcl")
}

  inputs = {
    org_iam_permissions   = [
      "roles/vmmigration.admin"
    ]
    member_name = "john.gadsby@placesforpeople.co.uk"
    member_type = "user"
  }
