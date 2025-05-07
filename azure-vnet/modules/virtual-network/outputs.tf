output "vnet_resource_group_name" {
  description = "The name of the Azure VNET Resource Group"
  value       = azurerm_resource_group.rg_vnet.name
}

output "vnet_resource_group_location" {
  description = "The location of the Azure VNET Resource Group"
  value       = azurerm_resource_group.rg_vnet.location
}

output "vnet_name" {
  description = "The name of the Azure VNET"
  value       = azurerm_virtual_network.vnet.name
}

output "vnet_id" {
  description = "The ID of the Azure VNET"
  value       = azurerm_virtual_network.vnet.id
}