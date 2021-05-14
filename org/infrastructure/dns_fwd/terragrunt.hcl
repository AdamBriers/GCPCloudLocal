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

dependency "ad_instances_centro" {
  config_path = "../ad/compute/centro_local"
}

dependency "ad_instances_group" {
  config_path = "../ad/compute/group_net"
}

dependency "ad_instances_luminus" {
  config_path = "../ad/compute/luminus_local"
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {

  project_id = dependency.vpc_host_project.outputs.project_id

  peering_zones = {
    dns-peer-group-net = {
      domain = "dns-peer-group.net."
      description = "DNS Zone used to peer the dev VPC to the records in the production VPC"
      private_visibility_config_networks = [dependency.vpc_shared_dev.outputs.network_self_link,]
      target_network = dependency.vpc_shared_prd.outputs.network_self_link
    },
    dns-peer-luminus-local = {
      domain = "dns-peer-luminus.local."
      description = "DNS Zone used to peer the dev VPC to the records in the production VPC"
      private_visibility_config_networks = [dependency.vpc_shared_dev.outputs.network_self_link,]
      target_network = dependency.vpc_shared_prd.outputs.network_self_link
    },
    dns-peer-centro-local = {
      domain = "dns-peer-centro.local."
      description = "DNS Zone used to peer the dev VPC to the records in the production VPC"
      private_visibility_config_networks = [dependency.vpc_shared_dev.outputs.network_self_link,]
      target_network = dependency.vpc_shared_prd.outputs.network_self_link
    },
  }

  forwarding_zones = {
    dns-forward-group-net = {
      domain = "group.net."
      description = "DNS Zone to forward requests to placesforpeople nameservers"
      private_visibility_config_networks = ["${dependency.vpc_shared_prd.outputs.network_self_link}", "${dependency.vpc_shared_dev.outputs.network_self_link}"]
      target_name_server_addresses = dependency.ad_instances_group.outputs.instances_IP_set
    },
    dns-forward-luminus-local = {
      domain = "luminus.local."
      description = "DNS Zone to forward requests to placesforpeople nameservers"
      private_visibility_config_networks = ["${dependency.vpc_shared_prd.outputs.network_self_link}", "${dependency.vpc_shared_dev.outputs.network_self_link}"]
      target_name_server_addresses = dependency.ad_instances_luminus.outputs.instances_IP_set
    },
    dns-forward-centro-local = {
      domain = "centro.local."
      description = "DNS Zone to forward requests to placesforpeople nameservers"
      private_visibility_config_networks = ["${dependency.vpc_shared_prd.outputs.network_self_link}", "${dependency.vpc_shared_dev.outputs.network_self_link}"]
      target_name_server_addresses = dependency.ad_instances_centro.outputs.instances_IP_set
    },
  }
}