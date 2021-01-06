locals {
  project_id = var.project_id
  folder_id  = var.folder_id != "" ? var.folder_id : null
}

module "cloudability_project" {
  source = "./../project"

  project_id = var.project_id
  folder_id  = var.folder_id

  billing_account = var.billing_account
  labels          = var.labels
  services        = var.services
}

resource "google_bigquery_dataset" "billing_dataset" {
  dataset_id  = var.dataset_id
  project     = module.cloudability_project.project.project_id
  description = "GCP Billing Export"
  location    = "EU"

  depends_on = [
    module.cloudability_project
  ]
}

resource "google_project_iam_custom_role" "cloudability_role" {
  role_id     = "CloudabilityRole_Billing"
  title       = "Cloudability Billing Role"
  description = "Allows Cloudability access to billing account data"
  permissions = ["bigquery.jobs.create", "bigquery.tables.getData"]
  project     = module.cloudability_project.project.project_id

  depends_on = [
    module.cloudability_project
  ]
}

resource "google_project_iam_member" "cloudability_project" {
  project = module.cloudability_project.project.project_id
  member  = "serviceAccount:${var.cloudability_sa}"
  role    = "projects/${module.cloudability_project.project.project_id}/roles/${google_project_iam_custom_role.cloudability_role.role_id}"

}