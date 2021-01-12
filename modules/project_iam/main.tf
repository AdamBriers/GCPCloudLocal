locals {
  member_id = var.member_type == "user" ? "user:${var.member_name}" : var.member_type == "serviceaccount" ? "serviceAccount:${var.member_name}" : var.member_type == "group" ? "group:${var.member_name}" : "domain:${var.member_name}"
}

resource "google_project_iam_member" "this" {
  for_each = toset(var.project_iam_permissions)

  project = var.project_id
  role   = each.value
  member = local.member_id
}