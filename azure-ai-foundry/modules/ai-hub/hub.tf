resource "azurerm_ai_foundry" "ai_hub" {
  name                    = var.ai_hub_name
  friendly_name           = var.ai_hub_name
  description             = "${var.ai_hub_name} Azure Foundry AI Hub"
  location                = var.location
  resource_group_name     = var.resource_group_name
  storage_account_id      = var.storage_account_id
  key_vault_id            = var.key_vault_id
  container_registry_id   = var.container_registry_id
  application_insights_id = var.application_insights_id

  managed_network {
    isolation_mode = var.isolation_mode
  }

  identity {
    type = "SystemAssigned"
  }
}
