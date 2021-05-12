output "peering_zone_name" {
  description = "The ID of the deployed DNS Zone."
  value       = module.dns_zone_peering.name
}

output "forwarding_zone_name" {
  description = "The ID of the deployed DNS Zone."
  value       = module.dns_forwarding_zone.name
}
