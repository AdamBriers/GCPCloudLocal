variable "project_id" {
  description = "The ID of the project to deploy into."
  type        = string
}

variable peering_zones {
  default     = {}
  description = "An object used to deploy Cloud DNS peering zones"
  type        = map(object({
    domain = string
    description = string
    private_visibility_config_networks = list(string) # selflink of the source vpc
    target_network = string # selflink of the target vpc
  }))
}

variable forwarding_zones {
  default     = {}
  description = "An object used to deploy Cloud DNS forwarding zones"
  type        = map(object({
    domain = string
    description = string
    private_visibility_config_networks = list(string) # selflink of the source vpc
    target_name_server_addresses = list(string) # IP addresses of AD servers
  }))
}
