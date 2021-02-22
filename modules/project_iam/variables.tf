variable "project_id" {
  description = "The organization id for the associated resource/module"
  type        = string
}

variable "project_members" {
  type        = list(object({ project_iam_permissions = list(string), member_type = string, member_name = string }))
  description = "List of project members and their permissions being created for this project"
  default     = []
}
