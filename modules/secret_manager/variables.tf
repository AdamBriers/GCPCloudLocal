variable project_id {
  type        = string
  description = "The project where the secrete manager will reside"
  default     = ""
}

variable secret {
  type = map(object({
    secret_location = list(string)
    secret_labels = map(string)
  }))
  default = {}
  description = "The list of secrets to be created"
}
