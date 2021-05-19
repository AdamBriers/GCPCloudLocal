# service-${project-id}@gcp-sa-vmmigration.iam.gserviceaccount.com
terraform {
  source = "../../../../../modules//project_iam/"
}

include {
  path = find_in_parent_folders("org.hcl")
}

dependency "vpc_host" {
  config_path = "../../../vpc_host_project"

  # Configure mock outputs for the terraform commands that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
  mock_outputs = {
    project_id = "project-not-created-yet"
  }
}

dependency "project" {
  config_path = "../../project"

  # Configure mock outputs for the terraform commands that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
  mock_outputs = {
    project_id = "project-not-created-yet"
  }
}

inputs = {
  project_id = dependency.vpc_host.outputs.project_id

  project_members = [
    {
      project_iam_permissions = ["roles/compute.subnetworks.use"]
      member_type             = "serviceaccount"
      member_name             = "service-${dependency.project.outputs.project_id}@gcp-sa-vmmigration.iam.gserviceaccount.com"
    }
  ]
}