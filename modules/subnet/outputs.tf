
output "sub_network_id" {
  value       = google_compute_subnetwork.sub_network.id
  description = "The subnetwork resource being created"
}

output "creation_timestamp" {
  value       = google_compute_subnetwork.sub_network.creation_timestamp
  description = "Creation timestamp in RFC3339 text format"
}

output "gateway_address" {
  value       = google_compute_subnetwork.sub_network.gateway_address
  description = "The gateway address for default routes to reach destination addresses outside this subnetwork"
}

output "sub_network_self_link" {
  value       = google_compute_subnetwork.sub_network.self_link
  description = "The URI of the subnetwork being created"
}
