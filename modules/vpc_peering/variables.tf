variable "name" {
  description = "Name for the network peerings"
  type        = string
}

variable "network" {
  description = "Resource link of the network to add a peering to."
  type        = string
}

variable "peer_network" {
  description = "he peer network in the peering. The peer network may belong to a different project."
  type        = string
}

variable "export_custom_routes" {
  description = "Whether to export the custom routes to the peer network."
  type        = bool
  default     = false
}

variable "import_custom_routes" {
  description = "Whether to import the custom routes from the peer network."
  type        = bool
  default     = false
}

variable "export_subnet_routes_with_public_ip" {
  description = "Whether subnet routes with public IP range are exported."
  type        = bool
  default     = false
}

variable "import_subnet_routes_with_public_ip" {
  description = "Whether subnet routes with public IP range are imported."
  type        = bool
  default     = false
}