variable "skip_default_network" {
  description = "Sets skip default network policy creation on projects if true"
  type        = bool
  default     = true
}

variable "require_oslogin" {
  description = "Sets the enforcement of OSLogin on compute if true"
  type        = bool
  default     = true
}

variable "uniform_bucket" {
  description = "Sets uniform level access to buckets if true"
  type        = bool
  default     = true
}

variable "vm_external_ip" {
  description = "Allow or deny for the VMs to have external IP. Default is to deny"
  type        = bool
  default     = false
}
variable "org_id" {
  description = "The organization id for the associated resource/module"
  type        = string
}

#variable "allowed_domain_ids" {
#  description = "(Only for list constraints) List of cloud identity domain ids allowed access. Default contains client.co.uk"
#  type        = list(string)
#  default     = ["C0391mc0z"]
#}

variable "resource_locations" {
  description = "(Only for list constraints) List of locations to allow resource creation"
  type        = list(string)
  default     = ["europe-west1", "europe-west2"]
}

