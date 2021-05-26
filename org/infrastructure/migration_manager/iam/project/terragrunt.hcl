terraform {
  source = "../../../../../modules//project_iam/"
}

include {
  path = find_in_parent_folders("org.hcl")
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
  project_id = dependency.project.outputs.project_id

  # This appears to be mostly oriented towards the cloud console UI
  # As such, members need to be added here who need access to Migrate
  # `roles/vmmigration.admin` -> Create and manage sources
  # `roles/vmmigration.viewer` -> View information, perform migrations
  project_members = [
    {
      project_iam_permissions = [
        # Roles required for initial setup
        # Google does implies against the viability of a service account for this
        # https://cloud.google.com/migrate/compute-engine/docs/5.0/how-to/migrate-connector#step-3
        "roles/vmmigration.admin",
        "roles/iam.serviceAccountKeyAdmin",
        "roles/iam.serviceAccountCreator"
      ]
      member_type             = "user"
      member_name             = "John.Gadsby@placesforpeople.co.uk"
    },
    {
      project_iam_permissions = [
        # To coordinate initial setup
        "roles/vmmigration.admin", "roles/iam.serviceAccountKeyAdmin", "roles/iam.serviceAccountCreator"
      ]
      member_type             = "user"
      member_name             = "skye.maddock@appsbroker.com"
    },
    {
      project_iam_permissions = [
        # To coordinate initial setup
        "roles/vmmigration.admin"
      ]
      member_type             = "user"
      member_name             = "theodor.valeanu@appsbroker.com"
    }
  ]
}