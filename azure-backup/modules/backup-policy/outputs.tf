output "instant_restore_resource_group_name" {
  description = "The name of the Instant Restore Resource Group"
  value       = azurerm_resource_group.rg_restore.name
}

output "vm_backup_policy_name" {
  description = "The name of the Azure VM workload Backup Policy"
  value       = azurerm_backup_policy_vm.vm_policy.name
}

output "sql_backup_policy_name" {
  description = "The name of the Azure SQL workload Backup Policy"
  value       = azurerm_backup_policy_vm_workload.sql_policy.name
}