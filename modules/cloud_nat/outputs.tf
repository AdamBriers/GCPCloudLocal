output "nat_id" {
  description = "The ID of the created Cloud NAT."
  value       = google_compute_router_nat.this.id
}

output "router" {
  description = "Router resource (only if auto-created)."
  value       = var.router_name == "" ? google_compute_router.this[0] : null
}

output "router_name" {
  description = "Router name."
  value       = local.router
}