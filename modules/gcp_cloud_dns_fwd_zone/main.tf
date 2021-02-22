resource "google_project_service" "this" {
  project = var.project_id
  service = "dns.googleapis.com"

  disable_dependent_services = true
}

resource "google_dns_managed_zone" "this" {
  name = var.name

  project     = var.project_id
  dns_name    = var.dns_name
  description = var.description
  visibility  = var.visibility

  private_visibility_config {
    dynamic "networks" {
      for_each = var.private_visibility_config_networks
      content {
        network_url = networks.value
      }
    }
  }
  forwarding_config {
    dynamic "target_name_servers" {
      for_each = var.target_name_server_addresses
      content {
        ipv4_address = target_name_servers.value
      }
    }
  }
  depends_on = [google_project_service.this]
}