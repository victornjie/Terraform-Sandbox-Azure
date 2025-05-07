resource "azurerm_virtual_network_peering" "spoke_vnet_peer" {
  name                      = "peer-${var.spoke_vnet_name}-to-${var.hub_vnet_name}"
  resource_group_name       = var.spoke_vnet_rg_name
  virtual_network_name      = var.spoke_vnet_name
  remote_virtual_network_id = var.hub_vnet_id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  use_remote_gateways          = true
}

resource "azurerm_virtual_network_peering" "hub_vnet_peer" {
  name                      = "peer-${var.hub_vnet_name}-to-${var.spoke_vnet_name}"
  resource_group_name       = var.hub_vnet_rg_name
  virtual_network_name      = var.hub_vnet_name
  remote_virtual_network_id = var.spoke_vnet_id

  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = true

  provider = azurerm.hub

  depends_on = [azurerm_virtual_network_peering.spoke_vnet_peer]
}