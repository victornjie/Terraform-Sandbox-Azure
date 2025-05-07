variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the route table"
}

variable "subnet_name" {
  type        = string
  description = "The name of the subnet"
}

variable "subnet_id" {
  type        = string
  description = "The ID of the subnet"
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

variable "az_firewall_ip" {
  type        = string
  description = "The private IP address of the Azure Firewall"
}

variable "internet_route" {
  description = "A mapping of internet routes to add to the route table"
  type = map(object({
    name              = string
    azure_service_tag = number
  }))

}
