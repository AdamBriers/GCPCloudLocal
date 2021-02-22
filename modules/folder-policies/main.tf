locals {
  allow_list_length = length(var.allow_list)
  deny_list_length  = length(var.deny_list)
}

module "restrict_shared_vpc_subnetworks_policy_folder" {
  source            = "terraform-google-modules/org-policy/google"
  version           = "~> 3.0.2"
  organization_id   = var.organization_id
  folder_id         = var.policy_folder_id
  policy_for        = var.policy_for
  policy_type       = var.policy_type
  enforce           = var.enforce
  allow             = var.allow_list
  allow_list_length = local.allow_list_length
  deny              = var.deny_list
  deny_list_length  = local.deny_list_length
  constraint        = var.constraint
  exclude_folders   = var.exclude_folders
  exclude_projects  = var.exclude_projects
  project_id        = var.project_id
}
