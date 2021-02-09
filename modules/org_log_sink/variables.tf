variable "org_id" {
  description = "The organization id for the associated resource/module"
  type        = string
}

variable "sink_name" {
  description = "The name to call the log sink."
  type        = string
}

variable "project_id" {
  description = "The project id for the associated resource/module"
  type        = string
}

variable "push_endpoint" {
  description = "The URL to push the message. For Splunk, something similar to https://SPLUNK_URL:8088/services/collector/raw?token=TOKEN_ID)"
  type        = string
  default     = ""
}

variable "sink_description" {
  description = "Brief description of the log sink."
  type        = string
  default     = ""
}

variable "disabled" {
  description = "logging exclusion filter set to disabled true/false."
  type        = string
  default     = false
}

variable "include_filter" {
  description = "The filter of logs to include."
  type        = string
  default     = false
}

variable "include_children" {
  description = "Either Includes or excludes child object logs in sink export."
  type        = bool
  default     = true
}
