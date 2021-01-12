variable "project_id" {
  description = "The organization id for the associated resource/module"
  type        = string
}

variable "project_iam_permissions" {
  description = "List of permissions granted to be granted across the GCP organization."
  type        = list(string)
}

variable "member_name" {
  description = "Account name or ID to be given permissions to"
  type        = string
}

variable "member_type" {
  description = "The type of the account to be granted permissions. Accepted values are user, serviceaccount, group, domain"
  type        = string
}