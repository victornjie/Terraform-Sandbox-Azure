output "rg_storage_account_name" {
  description = "The name of the Storage Account Resource Group"
  value       = azurerm_resource_group.rg_storage.name
}

output "storage_account_name" {
  description = "The name of the Storage Account"
  value       = azurerm_storage_account.storage.name
}

output "storage_account_id" {
  description = "The ID of the Storage Account"
  value       = azurerm_storage_account.storage.id
}