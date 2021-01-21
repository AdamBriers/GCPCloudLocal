locals {
  router = (
    var.router_name == ""
    ? google_compute_router.this[0].name
    : var.router_name
  )
}

resource "google_compute_router" "this" {
  name    = var.name
  count   = var.router_name == "" ? 1 : 0
  project = var.project_id
  region  = var.region
  network = var.network_selflink

  bgp {
    asn = var.router_asn
  }
}

resource "google_compute_router_nat" "this" {
  name = var.name

  project = var.project_id
  router  = local.router
  region  = var.region

  nat_ip_allocate_option             = var.nat_ip_allocate_option
  source_subnetwork_ip_ranges_to_nat = var.source_subnet_ip_ranges_to_nat

  log_config {
    enable = var.enable_logs
    filter = var.log_filter_level
  }
}
