
output "peer_id_first" {
  description = "An identifier for the first network resource with format {{network}}/{{name}}."
  value       = google_compute_network_peering.peering_first.id
}

output "peer_state_first" {
  description = "State for the first network peering, either ACTIVE or INACTIVE. The peering is ACTIVE when there's a matching configuration in the peer network."
  value       = google_compute_network_peering.peering_first.state
}

output "state_details_first" {
  description = "Details about the current state of the first network peering."
  value       = google_compute_network_peering.peering_first.state_details
}

output "peer_id_second" {
  description = "An identifier for the second network resource with format {{network}}/{{name}}."
  value       = google_compute_network_peering.peering_second.id
}

output "peer_state_second" {
  description = "State for the second netwrok peering, either ACTIVE or INACTIVE. The peering is ACTIVE when there's a matching configuration in the peer network."
  value       = google_compute_network_peering.peering_second.state
}

output "state_details_second" {
  description = "Details about the current state of the second network peering."
  value       = google_compute_network_peering.peering_second.state_details
}