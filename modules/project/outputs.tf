output "project" {
  description = "Project outputs"
  value       = google_project.project[0]
}

output "project_id" {

  value = google_project.project[0].project_id
}
