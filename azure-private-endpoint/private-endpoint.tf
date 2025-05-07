resource "azurerm_private_endpoint" "endpoint" {
  name                = var.endpoint_endpoint
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  subnet_id           = azurerm_subnet.example.id

  private_service_connection {
    name                           = var.private_link_name
    private_connection_resource_id = azurerm_storage_account.example.id
    subresource_names              = var.subresource_name
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "example-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.example.id]
  }
}