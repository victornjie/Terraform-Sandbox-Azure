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

/*resource "azurerm_virtual_machine_extension" "domain_join" {
  name                       = "${lower(var.vm_name)}-domainJoin-01"
  virtual_machine_id         = azurerm_windows_virtual_machine.vm.id
  publisher                  = "Microsoft.Compute"
  type                       = "JsonADDomainExtension"
  type_handler_version       = "1.3"
  auto_upgrade_minor_version = true

  settings = <<SETTINGS
    {
      "Name": "${var.domain_name}",
      "OUPath": "${var.ou_path}",
      "User": "${var.domain_user_upn}@${var.domain_name}",
      "Restart": "true",
      "Options": "3"
    }
  SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
    {
      "Password": "${var.domain_password}"
    }
  PROTECTED_SETTINGS

  lifecycle {
    ignore_changes = [settings, protected_settings]
  }
}*/

resource "azurerm_virtual_machine_extension" "vmext_dsc" {
  count                      = var.avd_vm_deployment ? 1 : 0
  name                       = "${lower(var.vm_name)}-avd_dsc-01"
  virtual_machine_id         = azurerm_windows_virtual_machine.vm.id
  publisher                  = "Microsoft.Powershell"
  type                       = "DSC"
  type_handler_version       = "2.73"
  auto_upgrade_minor_version = true

  settings = <<-SETTINGS
    {
      "modulesUrl": "https://wvdportalstorageblob.blob.core.windows.net/galleryartifacts/Configuration_09-08-2022.zip",
      "configurationFunction": "Configuration.ps1\\AddSessionHost",
      "properties": {
        "HostPoolName":"${var.host_pool_name}"
      }
    }
  SETTINGS

  protected_settings = <<PROTECTED_SETTINGS
  {
    "properties": {
      "registrationInfoToken": "${var.registration_token}"
    }
  }
  PROTECTED_SETTINGS

  /*depends_on = [
    azurerm_virtual_machine_extension.domain_join
  ]*/
}
