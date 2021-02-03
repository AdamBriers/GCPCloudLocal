
variable "allow_list" {
  description = "List of allowed ID's"
  type        = list(string)
  default     = []  
}

variable "deny_list" {
  description = "List of denied ID's"
  type        = list(string)
  default     = []  
}

variable "exclude_folders" {
  description = "Set of folders to exclude from the policy"
  type        = list(string)
  default     = []  
}

variable "exclude_projects" {
  description = "Set of projects to exclude from the policy"
  type        = list(string)
  default     = []  
}

variable "policy_folder_id" {
  description = "The ID of the folder to which the subnetwroks should be restricted"
  type        = string
}

variable "enforce" {
  description = "Whether to enforce the policy or not - Note the application of some policies will fail if this is set and not required"
  type        = bool
  default     = null
}

variable "organization_id" {
  description = "The Organisation ID - Note the application of some policies will fail if this is set and not required"
  type        = string
  default       = null
}

variable "policy_for" {
  description   = "Resource hierarchy node to apply the policy to: can be one of organization, folder, or project."
  type          = string
}

variable "policy_type" {
  description   = "The constraint type to work with (either 'boolean' or 'list')"
  type          = string
  default       = null
}

variable "constraint" {
  description   = "The constraint to be applied"
  type          = string
}

variable "project_id" {
  description = "The project id for putting the policy"
  type        = string
  default     = null
}