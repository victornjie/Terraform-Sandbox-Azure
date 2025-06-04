resource "azurerm_resource_group" "rg_ai" {
  name     = "rg-ai-foundry-eus2"
  location = "eastus2"

  tags = local.user_defined_tags
}

module "ai_foundry_service" {
  source = "./modules/ai-service"

  resource_group_name = azurerm_resource_group.rg_ai.name
  location = azurerm_resource_group.rg_ai.location
  ai_service_name = "ai-victormbock-test-001"
  custom_subdomain_name = "ai-victormbock-test-001"
  storage_account_id = "/subscriptions/97f16178-50de-44aa-baa1-ed27b0e733cb/resourceGroups/Lab-RG/providers/Microsoft.Storage/storageAccounts/testvic"
  
}