locals {
  # Ensure the org_id is not set if the folder_id is set as this will fail if both are set. 
  #   - If a folder_id is set the project is required to be created under a folder and
  #   not directly under the organisation
  org_id     = var.folder_id != "" ? null : var.org_id != "" ? var.org_id : null 
  folder_id  = var.folder_id != "" ? var.folder_id : null
}

resource "random_integer" "project-id" {
  min = 1000
  max = 9999
  keepers = {
    project_name = var.project_name
  }
}

resource "google_project" "project" {
  name            = var.project_name
  project_id      = "${var.project_name}-${random_integer.project-id.result}"

  billing_account = var.billing_account
  org_id          = local.org_id
  folder_id       = local.folder_id

  auto_create_network = false

  labels = var.labels

}

resource "google_project_service" "service" {
  for_each                   = toset(var.services)
  project                    = google_project.project.project_id
  service                    = each.value
  disable_on_destroy         = var.disable_on_destroy
  disable_dependent_services = var.disable_dependent_services
}

# A host project provides network resources to associated service projects.
resource "google_compute_shared_vpc_host_project" "host" {
  count = var.is_host_project ? 1 : 0
  project = google_project.project.project_id
}