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

variable "svc_acc_key_creation" {
  description = "Disables the ability to create and download service account keys"
  type        = bool
  default     = true
}

variable "uniform_bucket" {
  description = "Sets uniform level access to buckets if true"
  type        = bool
  default     = true
}

variable "svc_acc_grants" {
  description = "Does not grant project owner rights to default service account if true"
  type        = bool
  default     = true
}

variable "vm_external_ip" {
  description = "Allow or deny for the VMs to have external IP. Default is to deny"
  type        = bool
  default     = false
}