variable "project_id" {
  description = "The project ID, must be globally unique"
  type        = string
}

variable "billing_account" {
  description = "The ID of the billing account this project belongs to"
  type        = string
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
    "serviceusage.googleapis.com",
    "compute.googleapis.com",
    "logging.googleapis.com",
    "bigquery.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "cloudbilling.googleapis.com",
    "iam.googleapis.com",
    "admin.googleapis.com",
    "storage-api.googleapis.com",
    "monitoring.googleapis.com",
    "compute.googleapis.com"
  ]
}

variable "labels" {
  description = "Map of labels (i.e. tags) to add to resource"
  type        = map(string)
}

variable "dataset_id" {
  description = "ID of the Cloudability Dataset to create"
  type        = string
}

variable "cloudability_sa" {
  description = "Name of the Cloudability service account to provide access to billing account data"
  type        = string
}