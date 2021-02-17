output "name" {
  description = "The name of the created bucket resource."
  value       = google_storage_bucket.this.name
}

output "self_link" {
  description = "The URI of the created bucket resource."
  value       = google_storage_bucket.this.self_link
}

output "url" {
  description = "The base URL of the bucket, in the format gs://<bucket-name>."
  value       = google_storage_bucket.this.url
}
