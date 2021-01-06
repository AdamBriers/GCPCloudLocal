locals {
  allow_list_domain_length = length(regexall(".*all.*", join(",", var.allowed_domain_ids))) > 0 ? 0 : length(var.allowed_domain_ids)
  enforcement_domain       = local.allow_list_domain_length > 0 ? null : false
  #organization_id          = var.parent_folder != "" ? null : var.org_id
}

module "default_network_policy_folder" {
  source          = "terraform-google-modules/org-policy/google"
  version         = "~> 3.0"
  organization_id = var.organization_id
  #folder_id       = google_folder.gcpfolder.id
  policy_for      = "organization"
  policy_type     = "boolean"
  enforce         = var.skip_default_network
  constraint      = "compute.skipDefaultNetworkCreation"
}

module "oslogin_policy_folder" {
  source          = "terraform-google-modules/org-policy/google"
  version         = "~> 3.0"
  organization_id = var.organization_id
  #folder_id       = google_folder.gcpfolder.id
  policy_for      = "organization"
  policy_type     = "boolean"
  enforce         = var.require_oslogin
  constraint      = "constraints/compute.requireOsLogin"
}

module "svc_acc_key_policy_folder" {
  source          = "terraform-google-modules/org-policy/google"
  version         = "~> 3.0"
  organization_id = var.organization_id
  #folder_id       = google_folder.gcpfolder.id
  policy_for      = "organization"
  policy_type     = "boolean"
  enforce         = var.svc_acc_key_creation
  constraint      = "constraints/iam.disableServiceAccountKeyCreation"
}

module "svc_acc_grants_policy_folder" {
  source          = "terraform-google-modules/org-policy/google"
  version         = "~> 3.0"
  organization_id = var.organization_id
  #folder_id       = google_folder.gcpfolder.id
  policy_for      = "organization"
  policy_type     = "boolean"
  enforce         = var.svc_acc_grants
  constraint      = "iam.automaticIamGrantsForDefaultServiceAccounts"
}

module "uniform_bucket_policy_folder" {
  source          = "terraform-google-modules/org-policy/google"
  version         = "~> 3.0"
  organization_id = var.organization_id
  #folder_id       = google_folder.gcpfolder.id
  policy_for      = "organization"
  policy_type     = "boolean"
  enforce         = var.uniform_bucket
  constraint      = "constraints/storage.uniformBucketLevelAccess"
}

module "resource_locations_policy_folder" {
  source            = "terraform-google-modules/org-policy/google"
  version           = "~> 3.0"
  organization_id   = var.organization_id
  #folder_id         = google_folder.gcpfolder.id
  policy_for        = "organization"
  policy_type       = "list"
  allow             = var.resource_locations
  allow_list_length = length(var.resource_locations)
  constraint        = "constraints/gcp.resourceLocations"
}

module "resource_external_ip_policy_folder" {
  source          = "terraform-google-modules/org-policy/google"
  version         = "~> 3.0"
  organization_id = var.organization_id
  #folder_id       = google_folder.gcpfolder.id
  policy_for      = "organization"
  policy_type     = "list"
  enforce         = var.vm_external_ip
  constraint      = "constraints/compute.vmExternalIpAccess"
}

module "cloud_identity_domain_policy_folder" {
  source            = "terraform-google-modules/org-policy/google"
  version           = "~> 3.0"
  organization_id   = var.organization_id
  #folder_id         = google_folder.gcpfolder.id
  policy_for        = "organization"
  policy_type       = "list"
  allow             = var.allowed_domain_ids
  enforce           = local.enforcement_domain
  allow_list_length = local.allow_list_domain_length
  constraint        = "constraints/iam.allowedPolicyMemberDomains"
}

