variable "description" {
  description = "A description for the deployed DNS zone."
  type        = string
  default     = ""
}

variable "dns_name" {
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

variable "visibility" {
  description = "The visibility of the DNS zone."
  type        = string
  default     = "private"
}

variable "target_name_server_addresses" {
  description = "List of target name servers for forwarding zone."
  default     = []
  type        = list(string)
}
