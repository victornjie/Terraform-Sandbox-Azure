data "azurerm_subnet" "subnet" {
  name                 = "snet-app2-eus2"
  virtual_network_name = "test-vnet-eus2"
  resource_group_name  = "rg-test-network-eus2"
}