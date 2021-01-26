output "zone_id" {
  description = "The ID of the deployed DNS Zone."
  value       = google_dns_managed_zone.this.id
}
