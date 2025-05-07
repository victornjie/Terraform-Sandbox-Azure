resource "azurerm_resource_group" "rg_vnet" {
  name     = var.rg_vnet_name
  location = var.location

  tags = var.user_defined_tags
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = azurerm_resource_group.rg_vnet.location
  resource_group_name = azurerm_resource_group.rg_vnet.name
  address_space       = var.address_space
}

resource "azurerm_virtual_network_dns_servers" "dns" {
  virtual_network_id = azurerm_virtual_network.vnet.id
  dns_servers        = var.dns_servers
}