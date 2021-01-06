locals {
  member_id = var.member_type == "user" ? "user:${var.member_name}" : var.member_type == "serviceaccount" ? "serviceAccount:${var.member_name}" : var.member_type == "group" ? "group:${var.member_name}" : "domain:${var.member_name}"
}

resource "google_organization_iam_member" "org_permission" {
  for_each = toset(var.org_iam_permissions)

  org_id = var.org_id
  role   = each.value
  member = local.member_id
}
