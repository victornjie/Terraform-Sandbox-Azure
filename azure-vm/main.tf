module "windows_vm" {
  source         = "./modules/windows-vm"

  for_each = local.vm

  rg_vm_name     = local.rg_vm_name
  location       = local.location
  vm_name        = each.key //"${local.vm_name}-001"
  computer_name  = each.key //"${local.vm_name}-001"
  vm_size        = each.value.vm_size //local.vm_size
  vm_subnet_id   = data.azurerm_subnet.subnet.id
  admin_username = local.admin_username
  admin_password = local.admin_password
  license_type   = local.license_type
  os_publisher   = local.os_publisher
  os_offer       = local.os_offer
  os_sku         = local.os_sku
  os_version     = local.os_version
  disk_size_gb   = local.disk_size_gb

  user_defined_tags = local.user_defined_tags

}
