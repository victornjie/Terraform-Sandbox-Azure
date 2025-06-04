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

variable "ai_service_name" {
  type        = string
  description = "Specifies the name of the AI Services Account"
}

variable "custom_subdomain_name" {
  type        = string
  description = "The subdomain name used for token-based authentication"
}

variable "storage_account_id" {
  type        = string
  description = "The Storage Account ID that should be used by this AI Services Account"
}
