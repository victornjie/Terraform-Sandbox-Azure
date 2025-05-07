output "recovery_vault_resource_group_name" {
  description = "The name of the Recovery Services Vault Resource Group"
  value       = azurerm_resource_group.rg_vault.name
}

output "recovery_vault_name" {
  description = "The name of the Recovery Services Vault"
  value       = azurerm_recovery_services_vault.vault.name
}