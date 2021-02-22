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
  depends_on = [google_project_service.this]
}
resource "google_dns_record_set" "this" {
  project      = var.project_id
  managed_zone = var.name

  for_each = { for record in var.recordsets : join("/", [record.name, record.type]) => record }
  name = (
    each.value.name != "" ?
    "${each.value.name}.${var.dns_name}" :
    var.dns_name
  )
  type = each.value.type
  ttl  = each.value.ttl

  rrdatas = each.value.records

  depends_on = [google_dns_managed_zone.this]
}
