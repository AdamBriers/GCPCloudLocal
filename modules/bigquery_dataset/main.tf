resource "google_bigquery_dataset" "this" {
  project = var.project

  dataset_id                      = var.dataset_id
  default_table_expiration_ms     = var.default_table_expiration_ms == 0 ? null : var.default_table_expiration_ms
  default_partition_expiration_ms = var.default_partition_expiration_ms == 0 ? null : var.default_partition_expiration_ms
  delete_contents_on_destroy      = var.delete_contents_on_destroy
  description                     = var.description
  friendly_name                   = var.friendly_name
  location                        = var.location

  dynamic "access" {
    for_each = var.access

    content {
      domain         = lookup(access.value, "domain", null)
      group_by_email = lookup(access.value, "group_by_email", null)
      role           = lookup(access.value, "role", null)
      special_group  = lookup(access.value, "special_group", null)
      user_by_email  = lookup(access.value, "user_by_email", null)
    }
  }

  labels = var.labels
}