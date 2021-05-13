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
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {

  project_id     = dependency.vpc_host_project.outputs.project_id
  network        = dependency.vpc_network.outputs.network_self_link
  enable_logging = false
  firewall_rules = {
    all-ingress-testanddevtoprd = {
      description          = "INGRESS firewall for all ports and protocol from test and dev to production."
      direction            = "INGRESS"
      action               = "allow"
      ranges               = ["172.26.64.0/24", "172.26.68.0/24", "172.26.80.0/22", "172.26.112.0/23"]
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
    },

    iap-ingress-compute-prd-test = {
      description          = "For TEST Purposes ONLY - INGRESS firewall for SSH (TCP port 22) using 'IAP for TCP forwarding' to production environment."
      direction            = "INGRESS"
      action               = "allow"
      ranges               = ["35.235.240.0/20"]
      sources              = []
      targets              = []
      use_service_accounts = false
      rules = [
        {
          protocol = "tcp"
          ports    = ["22"]
        }
      ]
      extra_attributes = {}
    },

    vpnall-ingress-prd-azure-aws = {
      description          = "INGRESS firewall for all ports and protocol from on-prem, AWS and azure VPN to production."
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