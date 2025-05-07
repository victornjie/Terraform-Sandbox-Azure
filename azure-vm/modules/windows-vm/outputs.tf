output "vm_id" {
  description = "The ID of the Windows Virtual Machine"
  value       = azurerm_windows_virtual_machine.vm[*].id
}

output "vm_name" {
  description = "The name of the Windows Virtual Machine"
  value       = azurerm_windows_virtual_machine.vm[*].name
}

output "nic_name" {
  description = "The name of the Network Interface Card"
  value       = azurerm_network_interface.nic[*].name
}

output "nic_id" {
  description = "The ID of the Network Interface Card"
  value       = azurerm_network_interface.nic[*].id
}