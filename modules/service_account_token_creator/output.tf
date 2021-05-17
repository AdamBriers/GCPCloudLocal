output "email" {
  description = "The email address of the service account."
  value       = google_service_account.this.email
}

output "name" {
  description = "The fully-qualified name of the service account."
  value       = google_service_account.this.name
}
