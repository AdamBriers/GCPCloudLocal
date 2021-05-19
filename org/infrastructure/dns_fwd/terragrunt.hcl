# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
#locals {
#}

terraform {
  source = "../../../modules//gcp_cloud_dns_fwd_zone/"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders("org.hcl")
}

dependency "vpc_host_project" {
  config_path = "../vpc_host_project"
}

dependency "vpc_shared_prd" {
  config_path = "../vpc_shared_prd"
}
dependency "vpc_shared_dev" {
  config_path = "../vpc_shared_dev"
}

dependency "ad_derby_vm_a" {
  config_path = "../ad/compute/derby_a"

  # Configure mock outputs for the terraform commands that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
  mock_outputs = {
    ip_address = "10.1.1.1"
  }
}

dependency "ad_derby_vm_b" {
  config_path = "../ad/compute/derby_b"

  # Configure mock outputs for the terraform commands that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
  mock_outputs = {
    ip_address = "10.1.1.2"
  }
}

dependency "ad_group_vm_a" {
  config_path = "../ad/compute/group_net_a"

  # Configure mock outputs for the terraform commands that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
  mock_outputs = {
    ip_address = "10.1.1.3"
  }
}

dependency "ad_group_vm_b" {
  config_path = "../ad/compute/group_net_b"

  # Configure mock outputs for the terraform commands that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
  mock_outputs = {
    ip_address = "10.1.1.4"
  }
}

dependency "ad_huntingdon_vm_a" {
  config_path = "../ad/compute/huntingdon_a"

  # Configure mock outputs for the terraform commands that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
  mock_outputs = {
    ip_address = "10.1.1.5"
  }
}

dependency "ad_huntingdon_vm_b" {
  config_path = "../ad/compute/huntingdon_b"

  # Configure mock outputs for the terraform commands that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
  mock_outputs = {
    ip_address = "10.1.1.6"
  }
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {

  project_id = dependency.vpc_host_project.outputs.project_id

  peering_zones = {
    dns-peer-group-net = {
      domain = "dns-peer-group.net."
      description = "DNS Zone used to peer the test VPC to the records in the production VPC"
      private_visibility_config_networks = [dependency.vpc_shared_dev.outputs.network_self_link,]
      target_network = dependency.vpc_shared_prd.outputs.network_self_link
    },
    dns-peer-luminus-local = {
      domain = "dns-peer-luminus.local."
      description = "DNS Zone used to peer the test VPC to the records in the production VPC"
      private_visibility_config_networks = [dependency.vpc_shared_dev.outputs.network_self_link,]
      target_network = dependency.vpc_shared_prd.outputs.network_self_link
    },
    dns-peer-centro-local = {
      domain = "dns-peer-centro.local."
      description = "DNS Zone used to peer the test VPC to the records in the production VPC"
      private_visibility_config_networks = [dependency.vpc_shared_dev.outputs.network_self_link,]
      target_network = dependency.vpc_shared_prd.outputs.network_self_link
    },
  }

  forwarding_zones = {
    dns-forward-group-net = {
      domain = "group.net."
      description = "DNS Zone to forward requests to placesforpeople nameservers"
      private_visibility_config_networks = ["${dependency.vpc_shared_prd.outputs.network_self_link}", "${dependency.vpc_shared_dev.outputs.network_self_link}"]
      target_name_server_addresses = [dependency.ad_group_vm_a.outputs.ip_address, dependency.ad_group_vm_b.outputs.ip_address]
    },
    dns-forward-luminus-local = {
      domain = "luminus.local."
      description = "DNS Zone to forward requests to placesforpeople nameservers"
      private_visibility_config_networks = ["${dependency.vpc_shared_prd.outputs.network_self_link}", "${dependency.vpc_shared_dev.outputs.network_self_link}"]
      target_name_server_addresses = [dependency.ad_huntingdon_vm_a.outputs.ip_address, dependency.ad_huntingdon_vm_b.outputs.ip_address]
    },
    dns-forward-centro-local = {
      domain = "centro.local."
      description = "DNS Zone to forward requests to placesforpeople nameservers"
      private_visibility_config_networks = ["${dependency.vpc_shared_prd.outputs.network_self_link}", "${dependency.vpc_shared_dev.outputs.network_self_link}"]
      target_name_server_addresses = [dependency.ad_derby_vm_a.outputs.ip_address, dependency.ad_derby_vm_b.outputs.ip_address]
    },
  }
}