variable "account_id" {
  description = "The service account ID. Changing this forces a new service account to be created."
  type        = string
}

variable "description" {
  description = "Description of the service account purpose."
  type        = string
}

variable "members" {
  description = "List of members that require the Service Account Key Admin role on this Service Account."
  type        = list(any)
  default     = []
}

variable "project_id" {
  description = "The ID of the project that the service account will be created in."
  type        = string
}
