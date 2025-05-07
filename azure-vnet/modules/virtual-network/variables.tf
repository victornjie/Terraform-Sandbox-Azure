variable "rg_vnet_name" {
  type        = string
  description = "The name of the resource group in which to create the virtual network"
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

variable "vnet_name" {
  type        = string
  description = "The name of the virtual network"
}

variable "address_space" {
  type        = list(string)
  description = "The address space that is used the virtual network"
}

variable "dns_servers" {
  type        = list(string)
  description = "List of IP addresses of DNS servers"
  default     = null
}

variable "user_defined_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource"
}