variable "org_id" {
  description = "GCP Organization ID"
  type        = string
}

variable "billing_account" {
  description = "The ID of the billing account to associate projects with."
  type        = string
}

variable "default_region" {
  description = "Default region to create resources where applicable."
  type        = string
  default     = "europe-west2"
}

variable "bucket_location" {
  description = "Default region to create resources where applicable."
  type        = string
  default     = "EU"
}

variable "keyring_location" {
  description = "Default region to create resources where applicable."
  type        = string
  default     = "europe"
}

variable "project_name" {
  description = "Name to use for terraform project."
  default     = "cl-org-terraform-seed"
  type        = string
}

variable "project_labels" {
  description = "Labels to apply to the project."
  type        = map(string)
  default     = {}
}

variable "activate_apis" {
  description = "List of APIs to enable in the seed project."
  type        = list(string)

  default = [
    "serviceusage.googleapis.com",
    "servicenetworking.googleapis.com",
    "compute.googleapis.com",
    "logging.googleapis.com",
    "bigquery.googleapis.com",
    "cloudresourcemanager.googleapis.com",
    "cloudbilling.googleapis.com",
    "cloudbuild.googleapis.com",
    "cloudkms.googleapis.com",
    "iam.googleapis.com",
    "admin.googleapis.com",
    "appengine.googleapis.com",
    "storage-api.googleapis.com",
    "monitoring.googleapis.com",
    "billingbudgets.googleapis.com",
    "sourcerepo.googleapis.com"
  ]
}

variable "terraform_org_sa_name" {
  description = "Name of the main terraform Service Account which will handle the creation of everything"
  default     = "org-terraform"
  type        = string
}

variable "terraform_rnd_sa_name" {
  description = "Name of the main terraform Service Account which will handle the creation of everything"
  default     = "r-terraform-sa"
  type        = string
}

variable "terraform_dev_sa_name" {
  description = "Name of the main terraform Service Account which will handle the creation of everything"
  default     = "d-terraform-sa"
  type        = string
}

variable "terraform_prd_sa_name" {
  description = "Name of the main terraform Service Account which will handle the creation of everything"
  default     = "p-terraform-sa"
  type        = string
}

variable "sa_org_iam_permissions" {
  description = "List of permissions granted to Terraform service account across the GCP organization."
  type        = list(string)
  default = [
    "roles/billing.admin",
    "roles/compute.networkAdmin",
    "roles/compute.xpnAdmin",
    "roles/iam.securityAdmin",
    "roles/iam.serviceAccountAdmin",
    "roles/logging.configWriter",
    "roles/orgpolicy.policyAdmin",
    "roles/resourcemanager.folderAdmin",
    "roles/resourcemanager.organizationViewer",
    "roles/bigquery.admin",
    "roles/resourcemanager.projectCreator",
    "roles/serviceusage.serviceUsageAdmin",
  ]
}

variable "terraform_docs_version" {
  description = "The version of terraform-docs to be installed in the cloudbuild base deployment image"
  default     = "0.9.1"
  type        = string
}
