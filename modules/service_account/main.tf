resource "google_service_account" "this" {
  account_id = var.account_id

  description  = var.description
  display_name = var.account_id
  project      = var.project_id
}

resource "google_service_account_iam_binding" "key-admin-iam" {
  service_account_id = google_service_account.this.name

  role    = "roles/iam.serviceAccountKeyAdmin"
  members = var.members
}
