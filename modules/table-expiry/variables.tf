variable "bigquery_project" {
  description = "The target BigQuery project ID"
  type        = string
}

variable "bigquery_dataset" {
  description = "The target BigQuery dataset to set tables expiry"
  type        = string
}

variable "set_expiry" {
  description = "Controls the setup of table expiry. By default it won't run"
  type        = bool
  default     = false
}

variable "expiry_depends_on" {
  description = "The dependency of the table expiry setup"
  type        = any
  default = []
}

