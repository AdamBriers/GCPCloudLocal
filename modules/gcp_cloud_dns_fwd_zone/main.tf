resource "google_project_service" "this" {
  project = var.project_id
  service = "dns.googleapis.com"

  disable_dependent_services = true
}

module "dns_zone_peering" {
  for_each = var.peering_zones
  source  = "terraform-google-modules/cloud-dns/google"
  version = "3.1.0"

  name          = each.key
  project_id    = var.project_id
  type          = "peering"
  domain        = each.value.domain
  description   = each.value.description

  target_network                     = each.value.target_network
  private_visibility_config_networks = each.value.private_visibility_config_networks

  recordsets = []

  depends_on = [google_project_service.this]
}

module "dns_forwarding_zone" {
  for_each = var.forwarding_zones
  source  = "terraform-google-modules/cloud-dns/google"
  version = "3.1.0"

  name          = each.key
  project_id    = var.project_id
  type          = "forwarding"
  domain        = each.value.domain
  description   = each.value.description

  target_name_server_addresses       = each.value.target_name_server_addresses
  private_visibility_config_networks = each.value.private_visibility_config_networks

  recordsets = []

  depends_on = [google_project_service.this]
}