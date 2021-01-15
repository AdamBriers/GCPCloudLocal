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
  count = var.is_host_project && var.is_service_project ? 0 : 1  # Don't create this resouce if both host and service project type have been sepcified 
  name            = var.project_name
  project_id      = "${var.project_name}-${random_integer.project-id.result}"

  billing_account = var.billing_account
  org_id          = local.org_id
  folder_id       = local.folder_id

  auto_create_network = false

  labels = var.labels

}

resource "google_project_service" "service" {
  #count = var.is_host_project && var.is_service_project ? 0 : 1  # Don't create this resouce if both host and service project type have been sepcified 
  for_each                   = toset(var.is_host_project && var.is_service_project ? [] : var.services)
  project                    = google_project.project[0].project_id
  service                    = each.value
  disable_on_destroy         = var.disable_on_destroy
  disable_dependent_services = var.disable_dependent_services
}

# A Host project provides network resources to associated Service projects from an associated Shared VPC.
resource "google_compute_shared_vpc_host_project" "host" {
  count = var.is_host_project ? 1 : 0
  project = google_project.project[0].project_id
}

# A Service project is linked to a Host project and provides network resources from that Host project.
resource "google_compute_shared_vpc_service_project" "service" {
  count = var.is_service_project ? 1 : 0
  host_project    = var.host_project_id
  service_project = google_project.project[0].project_id
}