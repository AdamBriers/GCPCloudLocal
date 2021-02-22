
locals {
  subnets = {
    for i, subnet in var.subnets :
    lookup(subnet, "sub_network_name", "WARNING-SUBNETWORK-NAME-NOT-FOUND") => subnet
  }
}

resource "google_compute_subnetwork" "sub_network" {
  for_each = local.subnets

  project = var.project_id
  network = var.vpc_network_name

  name                     = each.key
  description              = lookup(each.value, "sub_network_description", "")
  ip_cidr_range            = lookup(each.value, "ip_cidr_range", "")
  region                   = lookup(each.value, "region", "")
  private_ip_google_access = lookup(each.value, "private_ip_google_access", "false")

  #description               = var.sub_network_description
  #ip_cidr_range             = var.ip_cidr_range 
  #region                    = var.region 
  #network                   = var.vpc_network_name 
  #private_ip_google_access  = var.private_ip_google_access

}

