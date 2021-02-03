resource "google_project_service" "this" {
  project = var.project_id
  service = "pubsub.googleapis.com"

  disable_dependent_services = true
}

resource "google_logging_organization_sink" "this" {
  disabled         = var.disabled
  name             = var.sink_name
  description      = var.sink_description
  org_id           = var.org_id
  destination      = "pubsub.googleapis.com/${google_pubsub_topic.this.id}"
  include_children = var.include_children
  filter           = var.include_filter

  depends_on = [ google_project_service.this ]
}

resource "google_pubsub_topic" "this" {
  name    = "${var.sink_name}-topic"
  project = var.project_id

  depends_on = [ google_project_service.this ]
}

resource "google_pubsub_topic_iam_member" "this" {
  project = var.project_id
  topic   = google_logging_organization_sink.this.destination
  role    = "roles/pubsub.publisher"
  member  = google_logging_organization_sink.this.writer_identity

  depends_on = [ google_project_service.this ]
}

resource "google_pubsub_subscription" "this" {
  name                 = "${var.sink_name}-subscription"
  project              = var.project_id
  topic                = google_pubsub_topic.this.name
  ack_deadline_seconds = 20
  push_config {
    push_endpoint = var.push_endpoint
  }

  depends_on = [ google_project_service.this ]
}