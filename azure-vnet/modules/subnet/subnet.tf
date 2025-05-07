resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = var.subnet_cidr

  service_endpoints = var.enable_service_endpoints ? var.service_endpoints : []

  dynamic "delegation" {
    for_each = var.enable_service_delegation ? ["apply"] : []
    content {
      name = var.delegation_name
      service_delegation {
        name = var.delegation_service
      }
    }
  }
}