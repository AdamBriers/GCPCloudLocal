module "org_admin_perms" {
  source = "./../org-permissions"

  org_iam_permissions = var.orgadmin_org_iam_permissions
  member_name         = var.org_admin_group
  member_type         = var.member_type
  org_id              = var.org_id
}

module "sec_admin_perms" {
  source = "./../org-permissions"

  org_iam_permissions = var.secadmin_org_iam_permissions
  member_name         = var.sec_admin_group
  member_type         = var.member_type
  org_id              = var.org_id
}

module "billing_admin_perms" {
  source = "./../org-permissions"

  org_iam_permissions = var.billingadmin_org_iam_permissions
  member_name         = var.billing_admin_group
  member_type         = var.member_type
  org_id              = var.org_id
}

module "billing_user_perms" {
  source = "./../org-permissions"

  org_iam_permissions = var.billingusers_org_iam_permissions
  member_name         = var.billing_users_group
  member_type         = var.member_type
  org_id              = var.org_id
}
