variable "allow_stopping_for_update" {
  description = "Allow TF to stop the instance to make changes."
  type        = string
  default     = true
}

variable "automatic_restart" {
  description = "Auto restart the instance after Google live migrate."
  type        = string
  default     = true
}

variable "boot_disk_auto_delete" {
  description = "Will the boot disk delete when deleting the instance."
  type        = string
  default     = true
}

variable "boot_disk_type" {
  description = "What type of disk for the boot disk."
  type        = string
  default     = "pd-standard"
}

variable "guest_accelerator" {
  description = "Attaching GPU type and count to the instance."
  default     = {}
}

variable "on_host_maintenance" {
  description = "Migrate or terminate on host migration."
  type        = string
  default     = "MIGRATE"
}

variable "preemptible" {
  description = "Preemptible short lived instance."
  type        = string
  default     = false
}

variable "subnetwork_project" {
  description = "The VPC subnetwork the instance will attach to."
  type        = string
  default     = "gc-a-prj-vpchost-0001-3312"
}

variable instance {
  description = "An object used to deploy one or more Cloud Engine Instances"
  type        = map(object({
    project = string
    machine_type = string # 
    network = string
    subnetwork = string
    zone = string
    ip_address = string
    os_image = string
    boot_disk_size = number
    gcp_instance_sa_email = string
    instance_tags = list(string)
    instance_scope = list(string)
    labels = map
    metadata_startup_script = string
  }))
}
