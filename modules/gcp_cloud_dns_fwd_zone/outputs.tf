output "peering_zone" {
  description = "The ID of the deployed DNS Zone."
  value       = module.dns_zone_peering
}

output "forwarding_zone" {
  description = "The ID of the deployed DNS Zone."
  value       = module.dns_forwarding_zone
}
