# ---------------------------------------------------------------------------------------------------------------------
# TERRAGRUNT CONFIGURATION
# Terragrunt is a thin wrapper for Terraform that provides extra tools for working with multiple Terraform modules,
# remote state, and locking: https://github.com/gruntwork-io/terragrunt
# ---------------------------------------------------------------------------------------------------------------------

# Configure Terragrunt to automatically store tfstate files: https://terragrunt.gruntwork.io/docs/features/keep-your-remote-state-configuration-dry/#create-remote-state-and-locking-resources-automatically
remote_state {
  backend = "gcs"

  # Same state bucket for for all envs
  config = {
    project = "gc-a-prj-cloudbld-0001-7087"
    bucket  = "gc-a-prj-cloudbld-0001-7087-terraform-state"
    prefix  = "${path_relative_to_include()}/terraform.tfstate"
  }
}

# Generate the GCP provider block
generate "gcp-provider" {
  path      = "providers.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "google" {
  alias = "impersonate"

  scopes = [
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/userinfo.email",
  ]
}

data "google_service_account_access_token" "default" {
  provider               = google.impersonate
  target_service_account = "gc-a-sa-tforg-0001@gc-a-prj-cloudbld-0001-7087.iam.gserviceaccount.com" #As indicated in terraform.tfvars inside bootstrap value terraform_sa_name
  scopes                 = ["userinfo-email", "cloud-platform"]
  lifetime               = "600s"
}

provider "google" {
  access_token = data.google_service_account_access_token.default.access_token
}

provider "google-beta" {
  access_token = data.google_service_account_access_token.default.access_token
}
EOF
}


# ---------------------------------------------------------------------------------------------------------------------
# GLOBAL PARAMETERS
# These variables apply to all configurations in this subfolder. These are automatically merged into the child
# `terragrunt.hcl` config via the include block.
# ---------------------------------------------------------------------------------------------------------------------

terraform {
  extra_arguments "var_files" {
    commands = "${get_terraform_commands_that_need_vars()}"

    optional_var_files = [
      "${find_in_parent_folders("org.tfvars", "ignore_org")}",
      "${find_in_parent_folders("environment.tfvars", "ignore_environment")}",
    ]
  }
}

