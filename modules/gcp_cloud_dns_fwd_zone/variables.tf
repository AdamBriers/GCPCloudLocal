variable "description" {
  description = "A description for the deployed DNS zone."
  type        = string
  default     = ""
}

variable "domain" {
  description = "The DNS name for the deployed Cloud DNS zone."
  type        = string
}

variable "name" {
  description = "The 'user assigned' name for the deployed DNS Zone."
  type        = string
}

variable "private_visibility_config_networks" {
  description = "List of VPC self links that can see this zone."
  default     = []
  type        = list(string)
}

variable "project_id" {
  description = "The ID of the project to deploy into."
  type        = string
}

variable "target_name_server_addresses" {
  description = "List of target name servers for forwarding zone."
  default     = []
  type        = list(string)
}

variable "dnssec_config" {
  description = "Object containing : kind, non_existence, state. Please see https://www.terraform.io/docs/providers/google/r/dns_managed_zone.html#dnssec_config for futhers details"
  type        = any
  default     = {}
}

variable "type" {
  type        = string
  description = "description"
}

variable peering_zones {
  default     = {}
  description = "An object used to deploy Cloud DNS peering zones"
  type        = map(object({
    domain = string
    description = string
    private_visibility_config_networks = string # selflink of the source vpc
    target_network = string # selflink of the target vpc
  }))
}
