output secret {
  value       = google_secret_manager_secret.this
  description = "The secret manager(s) created by this module"
}