variable "enable_logs" {
  description = "Whether logging should be enabled."
  type        = bool
  default     = true
}

variable "log_filter_level" {
  description = "Specifies the desired filtering of logs from this Cloud NAT instance."
  type        = string
  default     = "ALL"
}

variable "nat_ip_allocate_option" {
  description = "Defines how external IPs should be allocated for this NAT."
  type        = string
  default     = "AUTO_ONLY"
}

variable "network_selflink" {
  description = "The network the Cloud NAT should be deployed onto."
  type        = string
  default     = ""
}

variable "project_id" {
  description = "The id of the project containing the network."
  type        = string
}

variable "region" {
  description = "The region the underlying Cloud Router should be deployed to."
  type        = string
  default     = "europe-west2"
}

variable "router_asn" {
  description = "The ASN used by the router."
  type        = number
  default     = 64514
}

variable "source_subnet_ip_ranges_to_nat" {
  description = "How NAT should be configured per Subnetwork."
  type        = string
  default     = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

variable "router_name" {
  description = "Name of router to attach to. If left empty, will create a router"
  type        = string
  default     = ""
}

variable "name" {
  description = "Name of the cloud nat. Will also name the router if creating one."
  type        = string
}