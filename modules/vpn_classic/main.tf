locals {
  tunnel_name_prefix    = var.tunnel_name_prefix != "" ? var.tunnel_name_prefix : "${var.network}-${var.gateway_name}-tunnel"
}

resource "google_compute_vpn_gateway" "gateway" {
  project = var.project_id
  name    = var.gateway_name
  network = var.network
  region  = var.region
}

resource "google_compute_address" "static_ip" {
  project = var.project_id
  name   = var.ip_name
  region = var.region
}

#resource "google_compute_vpn_tunnel" "tunnel-static" {
#  count         = ! var.cr_enabled ? var.tunnel_count : 0
#  name          = var.tunnel_count == 1 ? format("%s-%s", local.tunnel_name_prefix, "1") : format("%s-%d", local.tunnel_name_prefix, count.index + 1)
#  region        = var.region
#  project       = var.project_id
#  peer_ip       = var.peer_ips[count.index]
#  shared_secret = data.google_secret_manager_secret_version.this.secret_data

#  target_vpn_gateway      = google_compute_vpn_gateway.gateway.self_link
#  local_traffic_selector  = var.local_traffic_selector
#  remote_traffic_selector = var.remote_traffic_selector

#  ike_version = var.ike_version

#  depends_on = [
#    google_compute_forwarding_rule.esp,
#    google_compute_forwarding_rule.udp500,
#    google_compute_forwarding_rule.udp4500,
#  ]
#}

resource "google_compute_forwarding_rule" "esp" {
  project     = var.project_id
  name        = "${var.gateway_name}-vpn-esp"
  region      = var.region
  ip_protocol = "ESP"
  ip_address  = google_compute_address.static_ip.address
  target      = google_compute_vpn_gateway.gateway.self_link
}

resource "google_compute_forwarding_rule" "udp500" {
  project     = var.project_id
  name        = "${var.gateway_name}-vpn-udp500"
  region      = var.region
  ip_protocol = "UDP"
  port_range  = "500"
  ip_address  = google_compute_address.static_ip.address
  target      = google_compute_vpn_gateway.gateway.self_link
}

resource "google_compute_forwarding_rule" "udp4500" {
  project     = var.project_id
  name        = "${var.gateway_name}-vpn-udp4500"
  region      = var.region
  ip_protocol = "UDP"
  port_range  = "4500"
  ip_address  = google_compute_address.static_ip.address
  target      = google_compute_vpn_gateway.gateway.self_link
}

#resource "google_compute_route" "route" {
#  count      = ! var.cr_enabled ? var.tunnel_count * length(var.remote_subnet) : 0
#  name       = "${google_compute_vpn_gateway.gateway.name}-tunnel${floor(count.index / length(var.remote_subnet)) + 1}-route${count.index % length(var.remote_subnet) + 1}"
#  network    = var.network
#  project    = var.project_id
#  dest_range = var.remote_subnet[count.index % length(var.remote_subnet)]
#  priority   = var.route_priority

#  next_hop_vpn_tunnel = google_compute_vpn_tunnel.tunnel-static[floor(count.index / length(var.remote_subnet))].self_link

#  depends_on = [google_compute_vpn_tunnel.tunnel-static]
#}

resource "google_project_service" "project" {
  project = var.project_id
  service = "secretmanager.googleapis.com"

  disable_dependent_services = true
}

#data "google_secret_manager_secret_version" "this" {
#  provider = google-beta
#  secret   = google_secret_manager_secret.this.id
#  version  = "1"
#}

resource "google_secret_manager_secret" "this" {
  project                   = var.project_id
  secret_id = var.secret_id

  replication {
    user_managed {
      replicas {
        location = "europe-west2"
      }
    }
  }
  depends_on = [google_project_service.project]
}
