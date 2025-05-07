resource "azurerm_route_table" "route_table" {
  name                          = "rt-${var.subnet_name}"
  location                      = var.location
  resource_group_name           = var.resource_group_name
  bgp_route_propagation_enabled = false
}

resource "azurerm_route" "default_route" {
  name                   = "default-gateway"
  resource_group_name    = var.resource_group_name
  route_table_name       = azurerm_route_table.route_table.name
  address_prefix         = "0.0.0.0/0"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = var.az_firewall_ip
}

resource "azurerm_route" "internet_route" {
  for_each            = var.internet_route
  name                = each.value.name
  resource_group_name = var.resource_group_name
  route_table_name    = azurerm_route_table.route_table.name
  address_prefix      = each.value.azure_service_tag
  next_hop_type       = "Internet"
}

resource "azurerm_subnet_route_table_association" "rt_association" {
  subnet_id      = var.subnet_id
  route_table_id = azurerm_route_table.route_table.id
}
