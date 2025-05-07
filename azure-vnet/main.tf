module "virtual_network_eus2" {
  source = "./modules/virtual-network"

  rg_vnet_name  = "rg-test-network-eus2"
  location      = "eastus2"
  vnet_name     = "test-vnet-eus2"
  address_space = ["10.10.0.0/16"]

  user_defined_tags = local.user_defined_tags
}

module "app_subnets_eus2" {
  source = "./modules/subnet"

  for_each = local.app_subnets_eus2

  resource_group_name       = module.virtual_network_eus2.vnet_resource_group_name
  vnet_name                 = module.virtual_network_eus2.vnet_name
  subnet_name               = each.value.subnet_name
  subnet_cidr               = each.value.subnet_cidr
  enable_service_delegation = false
  enable_service_endpoints  = false
  delegation_name           = ""
  delegation_service        = ""
  service_endpoints         = []

}

module "network_security_group_eus2" {
  source = "./modules/security-group"

  resource_group_name = module.virtual_network_eus2.vnet_resource_group_name
  location            = module.virtual_network_eus2.vnet_resource_group_location
  nsg_name            = "test-vnet-nsg"
  subnet_ids           = module.app_subnets_eus2
  nsg_inbound_rule    = local.nsg_inbound_rule
}
