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

variable "ai_hub_name" {
  type        = string
  description = "The name which should be used for this AI Foundry Hub"
}

variable "storage_account_id" {
  type        = string
  description = "The Storage Account ID that should be used by this AI Foundry Hub"
}

variable "key_vault_id" {
  type        = string
  description = "The Key Vault ID that should be used by this AI Foundry Hub"
}

variable "container_registry_id" {
  type        = string
  description = "(Optional) The Container Registry ID that should be used by this AI Foundry Hub"
  default = null
}

variable "application_insights_id" {
  type        = string
  description = "(Optional) The Application Insights ID that should be used by this AI Foundry Hub"
  default = null
}

variable "isolation_mode" {
  type        = string
  description = "(Optional) The Managed Network isolation mode of the AI Foundry Hub"
  default     = "AllowInternetOutbound"

  validation {
    condition     = contains(["AllowInternetOutbound", "AllowOnlyApprovedOutbound", "Disabled"], var.isolation_mode)
    error_message = "Allowed values are 'AllowInternetOutbound', 'AllowOnlyApprovedOutbound', or 'Disabled'"
  }
}