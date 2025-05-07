resource "azurerm_resource_group" "rg_vm" {
  name     = var.rg_vm_name
  location = var.location

  tags = var.user_defined_tags
}

resource "azurerm_network_interface" "nic" {
  name                = "nic-${lower(var.vm_name)}-01"
  location            = azurerm_resource_group.rg_vm.location
  resource_group_name = azurerm_resource_group.rg_vm.name

  accelerated_networking_enabled = true

  ip_configuration {
    name                          = "ipconfig-${lower(var.vm_name)}-01"
    subnet_id                     = var.vm_subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "vm" {
  name                = var.vm_name
  computer_name       = var.computer_name
  resource_group_name = azurerm_resource_group.rg_vm.name
  location            = azurerm_resource_group.rg_vm.location
  size                = var.vm_size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [
    azurerm_network_interface.nic.id
  ]

  license_type        = var.license_type
  provision_vm_agent  = true
  secure_boot_enabled = true
  vtpm_enabled        = true

  os_disk {
    name                 = "os-${lower(var.vm_name)}"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  //source_image_id = var.custom_image_id

  source_image_reference {
    publisher = var.os_publisher
    offer     = var.os_offer
    sku       = var.os_sku
    version   = var.os_version
  }

  boot_diagnostics {
    storage_account_uri = null
  }
}

resource "azurerm_managed_disk" "disk" {
  name                 = "data-${lower(var.vm_name)}-01"
  location             = azurerm_resource_group.rg_vm.location
  resource_group_name  = azurerm_resource_group.rg_vm.name
  storage_account_type = var.storage_account_type
  create_option        = "Empty"
  disk_size_gb         = var.disk_size_gb
}

resource "azurerm_virtual_machine_data_disk_attachment" "disk_attachment" {
  managed_disk_id    = azurerm_managed_disk.disk.id
  virtual_machine_id = azurerm_windows_virtual_machine.vm.id
  lun                = "1"
  caching            = "ReadWrite"
}

