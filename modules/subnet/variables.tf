variable "vpc_network_name" {
  type        = string
  description = "The name (ID) of the VPC with which this subnetwork should be linked"
}
variable "project_id" {
  description = "The ID of the Shared VPC Host project in which this subnetwork belongs"
}
variable "subnets" {
  type        = list(map(string))
  description = "List of subnets being created in this VPC"
  default     = []
}



#variable "sub_network_name" {
#  description = "The name of this subnetwork"
#}
#  type        = string

#variable "sub_network_description" {
#  description = "The description of this subnetwork being created"
#  type        = string
#}

#variable "ip_cidr_range" {
#  type        = string
#  description = "The CIDR range for this subnetwork"
#}

#variable "region" {
#  type        = string
#  description = "The Region in which this subnetwork should be created"
#}

#variable "private_ip_google_access" {
#  type        = bool
#  description = "Enables VMs in this subnetwork without external IP addresses to access Google APIs and services by using Private Google Access"
#  default     = false
#}
