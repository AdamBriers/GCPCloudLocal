variable "access" {
  description = "An array of objects that define dataset access for one or more entities."
  default     = []
}

variable "dataset_id" {
  description = "A unique ID for this dataset, without the project name."
  type        = string
}

variable "default_table_expiration_ms" {
  description = "The default lifetime of all tables in the dataset, in milliseconds."
  type        = number
}

variable "default_partition_expiration_ms" {
  description = "The default lifetime of a partition in a table within the dataset, in milliseconds."
  type        = number
  default     = 0
}

variable "delete_contents_on_destroy" {
  description = "Delete all the tables in the dataset when destroying the resource."
  type        = bool
  default     = false
}

variable "description" {
  description = "A user-friendly description of the dataset."
  type        = string
}


variable "friendly_name" {
  description = "A descriptive name for the dataset."
  type        = string
}

variable "labels" {
  description = "Map of labels associated with this dataset."
  default     = {}
}

variable "location" {
  description = "The geographic location where the dataset should reside."
  type        = string
  default     = "EU"
}

variable "project" {
  description = "The project ID for the project where the dataset will sit."
  type        = string
}
