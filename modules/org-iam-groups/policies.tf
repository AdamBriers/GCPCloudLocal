locals {
  allow_list_domain_length = length(regexall(".*all.*", join(",", var.allowed_domain_ids))) > 0 ? 0 : length(var.allowed_domain_ids)
  enforcement_domain       = local.allow_list_domain_length > 0 ? null : false
}

module "cloud_identity_domain_policy_organisation" {
  source            = "terraform-google-modules/org-policy/google"
  version           = "~> 3.0"
  organization_id   = var.org_id
  policy_for        = "organization"
  policy_type       = "list"
  allow             = var.allowed_domain_ids
  enforce           = local.enforcement_domain
  allow_list_length = local.allow_list_domain_length
  constraint        = "constraints/iam.allowedPolicyMemberDomains"
}

