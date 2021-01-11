output "dataset_id" {
  description = "A unique ID of the created dataset."
  value       = google_bigquery_dataset.this.dataset_id
}

output "self_link" {
  description = "The URI of the created resource."
  value       = google_bigquery_dataset.this.self_link
}
