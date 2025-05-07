variable "rg_pool_name" {
  type        = string
  description = "The name of the resource group in which to create the host pool"
}

variable "location" {
  type        = string
  description = "The Azure Region where the Resource Group should exist"
  default     = "eastus2"

  validation {
    condition     = contains(["eastus2", "centralus"], var.location)
    error_message = "Allowed values are 'eastus2' or 'centralus'"
  }
}

variable "pool_name" {
  type        = string
  description = "The name of the host pool"
}

variable "pool_type" {
  type        = string
  description = "The type of the Virtual Desktop Host Pool"
  default     = "Pooled"

  validation {
    condition     = contains(["Pooled", "Personal"], var.pool_type)
    error_message = "Allowed values are 'Pooled' or 'Personal'"
  }
}

variable "maximum_sessions_allowed" {
  type        = number
  description = "The maximum number of users that have concurrent sessions on a session host"
  default     = null
}

variable "user_defined_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource"
}
