resource "azurerm_resource_group" "rg_vault" {
  name     = var.rg_vault_name
  location = var.location

  tags = var.user_defined_tags
}

resource "azurerm_recovery_services_vault" "vault" {
  name                = var.vault_name
  location            = azurerm_resource_group.rg_vault.location
  resource_group_name = azurerm_resource_group.rg_vault.name
  sku                 = "Standard"

  soft_delete_enabled           = true
  public_network_access_enabled = true
  immutability                  = var.immutability
  storage_mode_type             = "GeoRedundant"
  cross_region_restore_enabled  = true

  monitoring {
    alerts_for_all_job_failures_enabled            = true
    alerts_for_critical_operation_failures_enabled = true
  }

  tags = var.user_defined_tags
}