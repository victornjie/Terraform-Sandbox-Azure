resource "azurerm_resource_group" "rg_pool" {
  name     = "rg-avd-host-pool-eus2"
  location = "eastus2"

  tags = local.user_defined_tags
}

resource "azurerm_resource_group" "rg_vm" {
  name     = "rg-avd-vm-host-eus2"
  location = "eastus2"

  tags = local.user_defined_tags
}

resource "azurerm_resource_group" "rg_gallery" {
  name     = "rg-compute-gallery-eus2"
  location = "eastus2"

  tags = local.user_defined_tags
}

module "avd_host_pool" {
  source = "./modules/avd-host-pool"

  for_each = local.host_pool

  resource_group_name      = azurerm_resource_group.rg_pool.name
  location                 = azurerm_resource_group.rg_pool.location
  pool_name                = each.value.pool_name
  pool_type                = each.value.pool_type
  maximum_sessions_allowed = each.value.maximum_sessions_allowed

}

module "desktop_vm_host" {
  source = "./modules/avd-vm-host"

  for_each = merge([for key, value in local.desktop_vm_host :
    { for i in range(value.vm_count) : "${key}-${i + 1}" => key }
  ]...)


  resource_group_name = azurerm_resource_group.rg_vm.name
  location            = azurerm_resource_group.rg_vm.location
  vm_name             = each.key
  computer_name       = each.key
  vm_size             = local.desktop_vm_host[each.value].vm_size #local.vm_size #local.base_pool_vm_host[each.value].vm_size
  vm_subnet_id        = data.azurerm_subnet.subnet.id
  admin_username      = local.admin_username
  admin_password      = local.admin_password
  license_type        = local.license_type
  avd_vm_deployment   = local.avd_vm_deployment
  os_publisher        = local.os_publisher
  os_offer            = local.os_offer
  os_sku              = local.os_sku
  os_version          = local.os_version
  host_pool_name      = module.avd_host_pool["desktop-pool"].avd_pool_name
  registration_token  = module.avd_host_pool["desktop-pool"].avd_registration_token


  depends_on = [module.avd_host_pool]
}

module "base_vm_host" {
  source = "./modules/avd-vm-host"

  //for_each = local.base_pool_vm_host

  //count = each.value.count

  for_each = merge([for key, value in local.base_vm_host :
    { for i in range(value.vm_count) : "${key}-${i + 1}" => key }
  ]...)

  resource_group_name = azurerm_resource_group.rg_vm.name
  location            = azurerm_resource_group.rg_vm.location
  vm_name             = each.key
  computer_name       = each.key
  vm_size             = local.base_vm_host[each.value].vm_size #local.vm_size #local.base_pool_vm_host[each.value].vm_size
  vm_subnet_id        = data.azurerm_subnet.subnet.id
  admin_username      = local.admin_username
  admin_password      = local.admin_password
  license_type        = local.license_type
  avd_vm_deployment   = local.avd_vm_deployment
  os_publisher        = local.os_publisher
  os_offer            = local.os_offer
  os_sku              = local.os_sku
  os_version          = local.os_version
  host_pool_name      = module.avd_host_pool["desktop-pool"].avd_pool_name
  registration_token  = module.avd_host_pool["desktop-pool"].avd_registration_token

  depends_on = [module.avd_host_pool]
}

/*module "avd_vm_host" {
  source             = "./modules/avd-vm-host"
  count              = 3
  rg_vm_name         = local.rg_vm_name
  location           = local.location
  vm_name            = "${local.vm_name}-00${count.index + 1}"
  computer_name      = "${local.vm_name}-00${count.index + 1}"
  vm_size            = local.vm_size
  vm_subnet_id       = data.azurerm_subnet.subnet.id
  admin_username     = local.admin_username
  admin_password     = local.admin_password
  license_type       = local.license_type
  avd_vm_deployment  = local.avd_vm_deployment
  os_publisher       = local.os_publisher
  os_offer           = local.os_offer
  os_sku             = local.os_sku
  os_version         = local.os_version
  host_pool_name     = module.avd_host_pool.avd_pool_name
  registration_token = module.avd_host_pool.avd_registration_token

  user_defined_tags = local.user_defined_tags

  depends_on = [module.avd_host_pool]
}*/

module "compute_gallery" {
  source = "./modules/azure-compute-gallery"

  resource_group_name = azurerm_resource_group.rg_gallery.name
  gallery_name        = local.gallery_name
  location            = azurerm_resource_group.rg_gallery.location
  image_name          = local.image_name
  image_os_type       = local.image_os_type
  image_publisher     = local.image_publisher
  image_offer         = local.image_offer
  image_sku           = local.image_sku
}
