variable "access" {
  description = "Maps of both identities and associated roles to be applied."
  default     = {}
}

variable "bucket_policy_only" {
  description = "Enables 'Bucket Policy Only' access to a bucket."
  type        = bool
  default     = true
}

variable "cors" {
  description = "The bucket's cross-origin resource sharing (CORS) configuration. Multiple blocks of this type are permitted."
  default     = []
}

variable "encryption" {
  description = "The bucket's encryption configuration."
  default     = []
}

variable "force_destroy" {
  description = "When deleting a bucket, this boolean option will delete all contained objects."
  type        = bool
  default     = false
}

variable "labels" {
  description = "Map of labels associated with this bucket."
  default     = {}
}

variable "lifecycle_rule" {
  description = "The bucket's lifecycle rules configuration. Multiple blocks of this type are permitted."
  default     = []
}

variable "location" {
  description = "The geographic location where the bucket should reside."
  type        = string
  default     = "EU"
}

variable "logging" {
  description = "The bucket's access & storage Logs configuration."
  default     = []
}

variable "name" {
  description = "The name of the bucket."
  type        = string
}

variable "project_id" {
  description = "The project ID for the project where the bucket will sit."
  type        = string
}

variable "requester_pays" {
  description = "Enables 'Requester Pays' on a storage bucket."
  type        = bool
  default     = false
}

variable "storage_class" {
  description = "The storage class of the new bucket."
  type        = string
  default     = "MULTI_REGIONAL"
}

variable "versioning" {
  description = "The bucket's versioning configuration."
  type        = bool
  default     = true
}

variable "website" {
  description = "Configuration if the bucket acts as a website."
  default     = []
}
