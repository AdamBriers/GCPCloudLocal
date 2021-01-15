
terraform {
  required_version = ">= 0.14.2"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 3.51"
    }
  }

  provider_meta "google" {
    module_name = "blueprints/terraform/terraform-google-network:vpc/v3.0.0"
  }
}
