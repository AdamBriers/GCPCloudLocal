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

variable "target_network" {
  description = "Peering network."
  default     = ""
}

variable "dnssec_config" {
  description = "Object containing : kind, non_existence, state. Please see https://www.terraform.io/docs/providers/google/r/dns_managed_zone.html#dnssec_config for futhers details"
  type        = any
  default     = {}
}