variable project_id {
  type        = string
  description = "The project where the secrete manager will reside"
  default     = ""
}

variable secret {
  type = list(object({ secret_id = string, secret_location = list(string) }))
  default = []
  description = "The list of secrets to be created"
}
