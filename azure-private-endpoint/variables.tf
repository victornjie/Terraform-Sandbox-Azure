variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the resources"
}

variable "location" {
  type        = string
  description = "The Azure Region where the resources should exist"
  default     = "eastus2"

  validation {
    condition     = contains(["eastus2", "centralus"], var.location)
    error_message = "Allowed values are 'eastus2' or 'centralus'"
  }
}

variable "endpoint_name" {
  type        = string
  description = "Specifies the Name of the Private Endpoint"
}

variable "subnet_id" {
  type        = string
  description = "The ID of the Subnet from which Private IP Addresses will be allocated for this Private Endpoint"
}

variable "service_name" {
  type        = string
  description = "Specifies the Name of the Private Service Connection"
}
