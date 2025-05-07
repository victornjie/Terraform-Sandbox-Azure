variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the network security group"
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

variable "nsg_name" {
  type        = string
  description = "The name of the network security group"
}

variable "subnet_ids" {
  description = "The ID of the Subnet to associate with the network security group"
  type = map(object({
    subnet_id = string
  }))
}

variable "nsg_inbound_rule" {
  description = "A mapping of ingress network security group rules"
  type = map(object({
    name                         = string
    priority                     = number
    access                       = string
    protocol                     = string
    destination_port_ranges      = list(string)
    source_address_prefixes      = list(string)
    destination_address_prefixes = list(string)
  }))

}
