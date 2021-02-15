variable "allow_stopping_for_update" {
  description = "Allow TF to stop the instance to make changes."
  type        = string
  default     = false
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

variable "boot_disk_size" {
  description = "Size of the instance boot disk in GB."
  type        = number
  default     = "20"
}

variable "boot_disk_type" {
  description = "What type of disk for the boot disk."
  type        = string
  default     = "pd-standard"
}

variable "gcp_instance_sa_email" {
  description = "The service account used for the instance."
  type        = string
}

variable "guest_accelerator" {
  description = "Attaching GPU type and count to the instance."
  default     = {}
}

variable "instance_name" {
  description = "Name of the VM instance."
  type        = string
}

variable "instance_scope" {
  description = "Scope permissions for the instance."
  default     = []
}

variable "instance_tags" {
  description = "What firewall tags to attach to the instance."
  default     = []
}

variable "labels" {
  description = "Labels to add."
  default     = {}
}

variable "machine_type" {
  description = "Specification of the VM instance."
  type        = string
  default     = "f1-micro"
}

variable "metadata_startup_script" {
  description = "Startup script to pass to the instance"
  type        = string
  default     = null
}

variable "network" {
  description = "The VPC network the instance will attach to."
  type        = string
}

variable "on_host_maintenance" {
  description = "Migrate or terminate on host migration."
  type        = string
  default     = "MIGRATE"
}

variable "os_image" {
  description = "The OS image name the instance will install and use."
  type        = string
}

variable "preemptible" {
  description = "Preemptible short lived instance."
  type        = string
  default     = false
}

variable "project" {
  description = "The project the instance will live in."
  type        = string
}

variable "subnetwork" {
  description = "The VPC subnetwork the instance will attach to."
  type        = string
  default     = null
}

variable "subnetwork_project" {
  description = "The VPC subnetwork the instance will attach to."
  type        = string
  default     = "gc-a-prj-vpchost-0001-3312"
}

variable "zone" {
  description = "What GCP zone the compute instance will run in."
  type        = string
  default     = "europe-west2-a"
}
