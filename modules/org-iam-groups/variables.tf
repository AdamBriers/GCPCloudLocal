variable "org_id" {
  description = "The organization id for the associated resource/module"
  type        = string
  default     = ""
}

variable "member_type" {
  description = "The type of the account to be granted permissions. Accepted values are user, serviceaccount, group, domain"
  type        = string
  default     = "group"
}

variable "orgadmin_org_iam_permissions" {
  description = "List of permissions granted to Organisational Admin group across the GCP organization."
  type        = list(string)
}

variable "org_admin_group" {
  description = "Organisational GCP Admin group"
  type        = string
}

variable "secadmin_org_iam_permissions" {
  description = "List of permissions granted to Security Admin group across the GCP organization."
  type        = list(string)
}

variable "sec_admin_group" {
  description = "Organisational GCP Security Admin group"
  type        = string
}

variable "billingadmin_org_iam_permissions" {
  description = "List of permissions granted to Billing Admin group across the GCP organization."
  type        = list(string)
}

variable "billing_admin_group" {
  description = "Organisational GCP Billing Admin group"
  type        = string
}

variable "billingusers_org_iam_permissions" {
  description = "List of permissions granted to Billing User Group across the GCP organization."
  type        = list(string)
}

variable "billing_users_group" {
  description = "Organisational GCP Billing User group"
  type        = string
}

variable "allowed_domain_ids" {
  description = "(Only for list constraints) List of cloud identity domain ids allowed access. Default contains client.co.uk"
  type        = list(string)
  default     = ["C0391mc0z"]
}


