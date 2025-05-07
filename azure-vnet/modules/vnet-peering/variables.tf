variable "spoke_vnet_rg_name" {
  type        = string
  description = "The name of the resource group in which to create the virtual network peering"
}

variable "spoke_vnet_name" {
  type        = string
  description = "The name of the virtual network"
}

variable "hub_vnet_rg_name" {
  type        = string
  description = "The name of the resource group in which to create the virtual network peering"
}

variable "hub_vnet_name" {
  type        = string
  description = "The name of the virtual network"
}

variable "spoke_vnet_id" {
  type        = string
  description = "The full Azure resource ID of the remote virtual network"
}

variable "hub_vnet_id" {
  type        = string
  description = "The full Azure resource ID of the remote virtual network"
}