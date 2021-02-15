output "instance_name" {
  description = "The name of the instance."
  value       = google_compute_instance.this.name
}

output "instance_self_link" {
  description = "The URI of the instance."
  value       = google_compute_instance.this.self_link
}
