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

variable "private_connection_resource_id" {
  type        = string
  description = "The ID of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to"
}

variable "subresource_names" {
  type        = list(string)
  description = "A list of subresource names which the Private Endpoint is able to connect to"
}

variable "dns_zone_group_name" {
  type        = string
  description = "Specifies the Name of the Private DNS Zone Group"
}

variable "dns_zone_ids" {
  type        = list(string)
  description = "Specifies the list of Private DNS Zones to include within the Private DNS Zone Group"
}
