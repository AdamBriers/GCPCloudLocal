# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
#locals {
#}

terraform {
  source = "../../../../modules//folder-policies/"

}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders("org.hcl")
}

dependency "subnets" {
  config_path = "../"

  # Configure mock outputs for the terraform commands that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
  mock_outputs = {
    subnet_ids = ["subnet-not-created-yet"]
  }
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {

  policy_folder_id = "1046798063212" ## Test and Development folder id
  allow_list       = dependency.subnets.outputs.subnet_ids
  deny_list        = []
  policy_for       = "folder"
  policy_type      = "list"
  constraint       = "constraints/compute.restrictSharedVpcSubnetworks"
  #enforce                 = null
  exclude_folders  = []
  exclude_projects = []
  organization_id  = null
  project_id       = null
}
