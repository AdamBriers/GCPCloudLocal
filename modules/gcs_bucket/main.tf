resource "google_storage_bucket" "this" {
  name    = var.name
  project = var.project_id

  force_destroy               = var.force_destroy
  location                    = var.location
  requester_pays              = var.requester_pays
  storage_class               = var.storage_class
  uniform_bucket_level_access = var.bucket_policy_only

  dynamic "cors" {
    for_each = var.cors

    content {
      origin          = lookup(cors.value, "origin", null)
      method          = lookup(cors.value, "method", null)
      response_header = lookup(cors.value, "response_header", null)
      max_age_seconds = lookup(cors.value, "max_age_seconds", null)
    }
  }

  dynamic "encryption" {
    for_each = var.encryption

    content {
      default_kms_key_name = encryption.value.default_kms_key_name
    }
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rule

    content {
      dynamic "action" {
        for_each = lifecycle_rule.value.action

        content {
          type          = action.value.type
          storage_class = action.value.storage_class
        }
      }

      dynamic "condition" {
        for_each = lifecycle_rule.value.condition

        content {
          age                   = lookup(condition.value, "age", null)
          created_before        = lookup(condition.value, "created_before", null)
          with_state            = lookup(condition.value, "with_state", null)
          matches_storage_class = lookup(condition.value, "matches_storage_class", null)
          num_newer_versions    = lookup(condition.value, "num_newer_versions", null)
        }
      }
    }
  }

  dynamic "logging" {
    for_each = var.logging

    content {
      log_bucket        = logging.value.log_bucket
      log_object_prefix = lookup(logging.value, "log_object_prefix", null)
    }
  }

  dynamic "website" {
    for_each = var.website

    content {
      main_page_suffix = lookup(website.value, "main_page_suffix", null)
      not_found_page   = lookup(website.value, "not_found_page", null)
    }
  }

  versioning {
    enabled = var.versioning
  }

  labels = var.labels
}

resource "google_storage_bucket_iam_binding" "this" {
  bucket = google_storage_bucket.this.name

  for_each = tomap(var.access)
  role     = each.key
  members  = each.value
}