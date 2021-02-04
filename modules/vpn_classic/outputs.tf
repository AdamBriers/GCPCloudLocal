output "gateway" {
  description = "HA VPN gateway resource."
  value       = google_compute_vpn_gateway.gateway
}

output "vpn_gw_name" {
  description = "VPN gateway name."
  value       = google_compute_vpn_gateway.gateway.name
}

output "vpn_gw_self_link" {
  description = "HA VPN gateway self link."
  value       = google_compute_vpn_gateway.gateway.self_link
}

output "vpn_gw_ip_self_link" {
  description = "HA VPN gateway self link."
  value       = google_compute_address.static_ip.self_link
}

output "vpn_tunnels_names-static" {
  description = "The VPN tunnel name is"
  value       = google_compute_vpn_tunnel.tunnel-static.*.name
}

output "vpn_tunnels_self_link-static" {
  description = "The VPN tunnel self-link is"
  value       = google_compute_vpn_tunnel.tunnel-static.*.self_link
}

output "vpn_tunnels_id" {
  description = "The VPN tunnel ID"
  value       = google_compute_vpn_tunnel.tunnel-static.*.id
}
