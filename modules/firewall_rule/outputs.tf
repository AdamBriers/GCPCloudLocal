output "firewall_selflink" {
  description = "self-link to the created firewall."
  value       = google_compute_firewall.this.self_link
}
