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
    project = "deployment-pipeline-7972"
    bucket  = "deployment-pipeline-7972-terraform-state"
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
  target_service_account = "sa-terraform-deployment@deployment-pipeline-7972.iam.gserviceaccount.com" #As indicated in terraform.tfvars inside bootstrap value terraform_sa_name
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

locals {
  # Automatically load environment-level variables
  #environment_vars = read_terragrunt_config(find_in_parent_folders("env.hcl"))
}

# Configure root level variables that all resources can inherit. This is especially helpful with multi-account configs
# where terraform_remote_state data sources are placed directly into the modules.
inputs = {

  billing_account = "0119B9-36A410-C6B39B",
  org_id          = "650414305409"
  #allowed_domain_ids = [
    # Appsbroker Cloud Identity Customer ID
  #  "C02l4xnhr",
    # Client Cloud Identity Customer ID
  #  "C0391mc0z"
  #]
  #merge(# local.environment_vars.locals,)
}
