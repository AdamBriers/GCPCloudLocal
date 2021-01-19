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

#output "tunnels" {
#  description = "VPN tunnel resources."
#  value = {
#    for name in keys(var.tunnels) :
#    name => google_compute_vpn_tunnel.tunnels[name]
#  }
#}

#output "tunnel_names" {
#  description = "VPN tunnel names."
#  value = {
#    for name in keys(var.tunnels) :
#    name => google_compute_vpn_tunnel.tunnels[name].name
#  }
#}

#output "tunnel_self_links" {
#  description = "VPN tunnel self links."
#  value = {
#    for name in keys(var.tunnels) :
#    name => google_compute_vpn_tunnel.tunnels[name].self_link
#  }
#}
