variable "name" {
  description = "Name for the first network"
  type        = string
}

variable "name_second" {
  description = "Name for the second network"
  type        = string
}
variable "network" {
  description = "Resource link of the first network."
  type        = string
}

variable "peer_network" {
  description = "Resource link of the second network"
  type        = string
}

variable "export_custom_routes" {
  description = "Whether to export the custom routes to the second peer network."
  type        = bool
  default     = false
}

variable "export_custom_routes_second" {
  description = "Whether to export the custom routes to the first peer network."
  type        = bool
  default     = false
}

variable "import_custom_routes" {
  description = "Whether the first peer should import the custom routes from the second peer network."
  type        = bool
  default     = false
}

variable "import_custom_routes_second" {
  description = "Whether second peer should import the custom routes from the first peer network."
  type        = bool
  default     = false
}
variable "export_subnet_routes_with_public_ip" {
  description = "Whether subnet routes with public IP range are exported from the first peer network."
  type        = bool
  default     = false
}

variable "export_subnet_routes_with_public_ip_second" {
  description = "Whether subnet routes with public IP range are exported from the second peer network."
  type        = bool
  default     = false
}

variable "import_subnet_routes_with_public_ip" {
  description = "Whether subnet routes with public IP range are imported to the first peer network."
  type        = bool
  default     = false
}

variable "import_subnet_routes_with_public_ip_second" {
  description = "Whether subnet routes with public IP range are imported to the second peer network from the first."
  type        = bool
  default     = false
}