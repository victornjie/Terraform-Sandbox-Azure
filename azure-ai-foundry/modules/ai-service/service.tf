resource "azurerm_ai_services" "ai_service" {
  name                               = var.ai_service_name
  location                           = var.location
  resource_group_name                = var.resource_group_name
  sku_name                           = "S0"
  custom_subdomain_name              = var.custom_subdomain_name
  local_authentication_enabled       = true
  outbound_network_access_restricted = false
  public_network_access              = "Disabled"

  identity {
    type = "SystemAssigned"
  }

  storage {
    storage_account_id = var.storage_account_id
  }

}
