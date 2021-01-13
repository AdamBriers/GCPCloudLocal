output "project" {
  description = "Project outputs"
  value       = google_project.project
}

output "project_id" {

  value = google_project.project.project_id
}
