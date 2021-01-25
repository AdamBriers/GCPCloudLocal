variable "allow_rules" {
  description = "A list of maps defining the 'allow' rules."
  type        = list
  default     = []
}

variable "deny_rules" {
  description = "A list of maps defining the 'deny' rules."
  type        = list
  default     = []
}

variable "description" {
  description = "A description for this firewall."
  type        = string
  default     = "Terraform managed firewall."
}

variable "destination_ranges" {
  description = "A list of destination IP Ranges (in CIDR format) this EGRESS rule applies to."
  type        = list
  default     = null
}

variable "direction" {
  description = "Whether this rule applies to INGRESS or EGRESS traffic."
  type        = string
}

variable "disabled" {
  description = "Whether this Firewall configuration should be disabled."
  type        = bool
  default     = false
}

variable "enable_logging" {
  description = "Enable stackdriver logging for this rule."
  type        = bool
  default     = false
}

variable "name" {
  description = "The name of the firewall rule to create."
  type        = string
}

variable "network_name" {
  description = "The name of the network to create the firewall on."
  type        = string
}

variable "priority" {
  description = "The network priority that applies to this firewall configuration."
  type        = number
  default     = 1000
}

variable "project_id" {
  description = "The ID of the project to be used."
  type        = string
}

variable "source_ranges" {
  description = "The IP Ranges (in CIDR format) this INGRESS rule should apply to."
  type        = list
  default     = null
}

variable "source_service_accounts" {
  description = "A list of service accounts that can use this INGRESS rule."
  type        = list
  default     = null
}

variable "source_tags" {
  description = "The source tags that this INGRESS rule should apply to."
  type        = list
  default     = null
}

variable "target_service_accounts" {
  description = "A list of service accounts that can use this rule."
  type        = list
  default     = null
}

variable "target_tags" {
  description = "A list of instance tags that can use this rule."
  type        = list
  default     = null
}
