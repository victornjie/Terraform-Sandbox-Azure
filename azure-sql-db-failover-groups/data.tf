data "azurerm_subnet" "subnet" {
  name                 = "snet-app2-eus2"
  virtual_network_name = "test-vnet-eus2"
  resource_group_name  = "rg-test-network-eus2"
  provider             = azurerm
}

data "azurerm_key_vault" "key_vault" {
  name                = "test-keyvault-eus2"
  resource_group_name = "Lab-RG"
  provider            = azurerm
}

data "azurerm_key_vault_secret" "admin_password" {
  name         = "admin-password"
  key_vault_id = data.azurerm_key_vault.key_vault.id
  provider     = azurerm
}
