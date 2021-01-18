
resource "google_compute_subnetwork" "sub_network" {
  name                      = var.sub_network_name
  description               = var.sub_network_description
  ip_cidr_range             = var.ip_cidr_range 
  region                    = var.region 
  network                   = var.vpc_network_name 
  private_ip_google_access  = var.private_ip_google_access
  project                   = var.project_id
}

