resource "google_compute_firewall" "this" {
  name = var.name

  project                 = var.project_id
  description             = var.description
  disabled                = var.disabled
  network                 = var.network_name
  direction               = var.direction
  priority                = var.priority
  destination_ranges      = var.destination_ranges
  source_ranges           = var.source_ranges
  source_service_accounts = var.source_service_accounts
  source_tags             = var.source_tags
  target_service_accounts = var.target_service_accounts
  target_tags             = var.target_tags

  dynamic "allow" {
    for_each = var.allow_rules
    content {
      protocol = allow.value.protocol
      ports    = allow.value.ports
    }
  }

  dynamic "deny" {
    for_each = var.deny_rules
    content {
      protocol = deny.value.protocol
      ports    = lookup(deny.value, "ports", null)
    }
  }

  dynamic "log_config" {
    for_each = var.enable_logging == true ? [1] : []
    content {
      metadata = "INCLUDE_ALL_METADATA"
    }
  }

}
