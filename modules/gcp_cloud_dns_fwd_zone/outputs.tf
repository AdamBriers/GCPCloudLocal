output "zone_name" {
  description = "The ID of the deployed DNS Zone."
  value       = module.dns_zone.name
}
