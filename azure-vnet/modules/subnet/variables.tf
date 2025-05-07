variable "subnet_name" {
  type        = string
  description = "The name of the subnet"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the subnet"
}

variable "vnet_name" {
  type        = string
  description = "The name of the virtual network to which to attach the subnet"
}

variable "subnet_cidr" {
  type        = list(string)
  description = "The address prefixes to use for the subnet"
}

variable "service_endpoints" {
  type        = list(string)
  description = "The list of Service endpoints to associate with the subnet"
}

variable "delegation_name" {
  type        = string
  description = "The subnet delegation name"
}

variable "delegation_service" {
  type        = string
  description = "The name of service to delegate to"
}

variable "enable_service_endpoints" {
  type        = bool
  description = "Enable service endpoints for the subnet"
  default     = false
}

variable "enable_service_delegation" {
  type        = bool
  description = "Enable service delegation for the subnet"
  default     = false
}