variable "org_name" {
  type        = "string"
  description = "Organization name"
}

variable "product" {
  type        = "string"
  description = "The name of your application"
}

variable "env" {
  type        = "string"
  description = "The deployment environment (sandbox, aat, prod etc..)"
}

variable "common_tags" {
  type = "map"
}


variable "resource_group" {
  type        = "string"
  description = "Name of the resource group"
}

variable "traffic_manager_endpoints" {
  type = "list"
  description = "Traffic Manager Endpoint list"
}

variable "endpoints_count" {
  description = "Number of Traffic Manager endpoint"
}