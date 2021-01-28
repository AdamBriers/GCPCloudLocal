resource "google_compute_network_peering" "peering_first" {
 
  name                                = var.name
  network                             = var.network
  peer_network                        = var.peer_network
  export_custom_routes                = var.export_custom_routes
  import_custom_routes                = var.import_custom_routes
  export_subnet_routes_with_public_ip = var.export_subnet_routes_with_public_ip
  import_subnet_routes_with_public_ip = var.import_subnet_routes_with_public_ip
}

resource "google_compute_network_peering" "peering_second" {
 
  name                                = var.name_second
  network                             = var.peer_network
  peer_network                        = var.network
  export_custom_routes                = var.export_custom_routes_second
  import_custom_routes                = var.import_custom_routes_second
  export_subnet_routes_with_public_ip = var.export_subnet_routes_with_public_ip_second
  import_subnet_routes_with_public_ip = var.import_subnet_routes_with_public_ip_second
}