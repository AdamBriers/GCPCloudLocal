variable "project_name" {
  description = "The project name. The project ID uses this as a base then appends 4 random digits to keep it globally unique"
  type        = string
}

variable "billing_account" {
  description = "The ID of the billing account this project belongs to"
  type        = string
}

variable "org_id" {
  description = <<EOF
  The organization ID this project belongs to.
  Only one of org_id or folder_id may be specified. 
  If the org_id is specified then the project is created at the top level.
  If the folder_id is specified, then the project is created under the specified folder.
EOF
  type        = string
  default     = ""
}

variable "folder_id" {
  description = <<EOF
  The ID of the folder this project should be created under.
  Only one of org_id or folder_id may be specified. 
  If the org_id is specified then the project is created at the top level.
  If the folder_id is specified, then the project is created under the specified folder.
EOF
  type        = string
  default     = ""
}

variable "services" {
  description = "The list of APIs to activate within the project: https://cloud.google.com/service-usage/docs/enabled-service"
  type        = list(string)
  default = [
    "iam.googleapis.com",
    "cloudbilling.googleapis.com",
    "billingbudgets.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "serviceusage.googleapis.com",
    "compute.googleapis.com",
    "container.googleapis.com",
    "storage-api.googleapis.com",
    "bigquery.googleapis.com",
    "cloudbuild.googleapis.com",
    "logging.googleapis.com",
    "monitoring.googleapis.com"
  ]
}

variable "disable_on_destroy" {
  description = "Whether project services will be disabled when the resources are destroyed. https://www.terraform.io/docs/providers/google/r/google_project_service.html#disable_on_destroy"
  default     = true
  type        = bool
}

variable "disable_dependent_services" {
  description = "Whether services that are enabled and which depend on this service should also be disabled when this service is destroyed. https://www.terraform.io/docs/providers/google/r/google_project_service.html#disable_dependent_services"
  default     = true
  type        = bool
}

variable "labels" {
  description = "Map of labels (i.e. tags) to add to resource"
  type        = map(string)
}
