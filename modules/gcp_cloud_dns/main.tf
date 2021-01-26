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
  depends_on = [ google_project_service.this ]
}

resource "google_dns_record_set" "cname-record" {
  name = var.cname_record_dns_name

  project      = var.project_id
  managed_zone = google_dns_managed_zone.this.name
  type         = "CNAME"
  ttl          = var.cname_record_ttl

  rrdatas = [var.cname_record_canonical_name]
}

resource "google_dns_record_set" "a-record" {
  name = var.a_record_dns_name

  project      = var.project_id
  managed_zone = google_dns_managed_zone.this.name
  type         = "A"
  ttl          = var.a_record_ttl

  rrdatas = var.a_record_addresses
}
