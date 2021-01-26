variable "a_record_addresses" {
  description = "The list of IP addresses the A record should use."
  type        = list
}

variable "a_record_dns_name" {
  description = "The DNS name the A record will apply to."
  type        = string
}

variable "a_record_ttl" {
  description = "The TTL (Time To Live) value (in seconds) for the A record."
  type        = number
  default     = 300
}

variable "cname_record_canonical_name" {
  description = "The Canonical Name for the CName record."
  type        = string
}

variable "cname_record_dns_name" {
  description = "The DNS name the CName record will apply to."
  type        = string
}

variable "cname_record_ttl" {
  description = "The TTL (Time To Live) value (in seconds) for the CName record."
  type        = number
  default     = 300
}

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
