# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
#locals {
#}

terraform {
  source = "../../../../modules//firewall_rule/"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders("org.hcl")
}

dependency "vpc_host_project" {
  config_path = "../../vpc_host_project"
}

dependency "vpc_network" {
  config_path = "../"

  # Configure mock outputs for the terraform commands that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
  mock_outputs = {
    network_self_link = "network-not-created-yet"
  }
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {

  project_id     = dependency.vpc_host_project.outputs.project_id
  network        = dependency.vpc_network.outputs.network_self_link
  enable_logging = false
  firewall_rules = {
    vpnall-ingress-edge-azure-aws = {
      description          = "INGRESS firewall for all ports and protocol from on-prem, AWS and azure VPN to edge."
      direction            = "INGRESS"
      action               = "allow"
      ranges               = ["172.20.0.0/16", "172.30.0.0/16", "10.0.0.0/8", "172.21.0.0/16", "172.16.101.0/24"]
      sources              = []
      targets              = []
      use_service_accounts = false
      rules = [
        {
          protocol = "all"
          ports    = []
        }
      ]
      extra_attributes = {}
    }
  }
}