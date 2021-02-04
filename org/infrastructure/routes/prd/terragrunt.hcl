# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
#locals {
#}

terraform {
  source = "../../../../modules//routes/"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders("org.hcl")
}

dependency "vpc_shared_prd" {
  config_path = "../../vpc_shared_prd"
  
  # Configure mock outputs for the terraform commands that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
  mock_outputs = {
    network_name = "network-not-created-yet"
  }
}

dependency "vpc_host_project" {
  config_path = "../../vpc_host_project"
  
  # Configure mock outputs for the terraform commands that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
  mock_outputs = {
    project_id      = "project-not-created-yet"
  }
}

dependency "vpn_on_prem" {
  config_path = "../../vpn/on_prem"
  
  # Configure mock outputs for the terraform commands that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
  mock_outputs = {
    self_link = "vpn-not-created-yet"
  }
}

dependency "vpn_on_prem" {
  config_path = "../../vpn/on_prem"
  
  # Configure mock outputs for the terraform commands that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
  mock_outputs = {
    self_link = "vpn-not-created-yet"
  }
}

dependency "vpn_azure" {
  config_path = "../../vpn/azure"
  
  # Configure mock outputs for the terraform commands that are returned when there are no outputs available (e.g the
  # module hasn't been applied yet.
  mock_outputs_allowed_terraform_commands = ["plan", "validate"]
  mock_outputs = {
    vpn_gw_self_link = "vpn-not-created-yet"
  }
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {

  project_id    = dependency.vpc_host_project.outputs.project_id
  network_name  = dependency.vpc_shared_prd.outputs.network_name
  routes        = [
    {
      name                    = "gc-p-rt-0001"
      description             = "Route through to the internet"
      destination_range       = "0.0.0.0/0"
      tags                    = "" # List of Network tags assigned to this route. Empty list means all instances can use it.
      next_hop_internet       = "true"
      priority                = 1000
      next_hop_ip             = null
      next_hop_instance       = null
      next_hop_instance_zone  = null
      next_hop_vpn_tunnel     = null
    },
     {
      name                    = "gc-p-rt-0002"
      description             = "Route through to the PFP Azure network via VPN"
      destination_range       = "172.20.0.0/16"
      tags                    = "" # List of Network tags assigned to this route. Empty list means all instances can use it.
      next_hop_internet       = "false"
      priority                = 500
      next_hop_ip             = null
      next_hop_instance       = null
      next_hop_instance_zone  = null
      # IMPORTANT:  Note that the following 'next_hop_vpn_tunnel' only allows for the first Clasic VPN tunnel created
      # created - The vpn_classic module at time of writing is in theory capable of creating multiple 
      # VPN tunnels.  The routes module would need to be adjusted to cope with this, but also at the 
      # time of writing the Classic VPN was in the process of being replaced by a HA VPN, in which
      # case this route would not be required at all as routes are dynamic with HA VPN's.
      next_hop_vpn_tunnel     = dependency.vpn_azure.outputs.vpn_tunnels_self_link-static[0]
    },
     {
      name                    = "gc-p-rt-0003"
      description             = "Route through to the PFP Azure network via VPN"
      destination_range       = "172.30.0.0/16"
      tags                    = "" # List of Network tags assigned to this route. Empty list means all instances can use it.
      next_hop_internet       = "false"
      priority                = 500
      next_hop_ip             = null
      next_hop_instance       = null
      next_hop_instance_zone  = null
      # IMPORTANT:  Note that the following 'next_hop_vpn_tunnel' only allows for the first Clasic VPN tunnel created
      # created - The vpn_classic module at time of writing is in theory capable of creating multiple 
      # VPN tunnels.  The routes module would need to be adjusted to cope with this, but also at the 
      # time of writing the Classic VPN was in the process of being replaced by a HA VPN, in which
      # case this route would not be required at all as routes are dynamic with HA VPN's.
      next_hop_vpn_tunnel     = dependency.vpn_azure.outputs.vpn_tunnels_self_link-static[0]
    },
  ]
}