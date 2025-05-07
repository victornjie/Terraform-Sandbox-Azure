resource "azurerm_resource_group" "rg_vmss" {
  name     = var.rg_vmss_name
  location = var.location

  tags = var.user_defined_tags
}

resource "azurerm_linux_virtual_machine_scale_set" "vmss" {
  name                            = var.vmss_name
  resource_group_name             = azurerm_resource_group.rg_vmss.name
  location                        = azurerm_resource_group.rg_vmss.location
  sku                             = var.vmss_sku
  instances                       = 2
  admin_username                  = "PSGAdmin"
  admin_password                  = "Windows@2020"
  disable_password_authentication = false
  provision_vm_agent              = true

  /*admin_ssh_key {
    username   = "adminuser"
    public_key = local.first_public_key
  }*/

  dynamic "source_image_reference" {
    for_each = var.source_image_reference
    iterator = image
    content {
      publisher = image.value.publisher
      offer     = image.value.offer
      sku       = image.value.sku
      version   = image.value.version
    }
  }

  os_disk {
    storage_account_type = "Premium_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name                          = "nic-${var.vmss_name}-01"
    primary                       = true
    enable_accelerated_networking = true

    ip_configuration {
      name      = "ipconfig-${var.vmss_name}-01"
      primary   = true
      subnet_id = data.azurerm_subnet.subnet.id
    }
  }

  identity {
    type = "SystemAssigned"
  }

  upgrade_mode                = "Manual"
  overprovision               = false
  platform_fault_domain_count = 1
  single_placement_group      = false

  secure_boot_enabled = true
  vtpm_enabled        = true

  boot_diagnostics {
    storage_account_uri = null
  }

  extension_operations_enabled = true

  extension {
    name                       = "CustomScript"
    type                       = "CustomScript"
    publisher                  = "Microsoft.Azure.Extensions"
    type_handler_version       = "2.0"
    auto_upgrade_minor_version = true

    settings = <<SETTINGS
        {
            "fileUris": ["https://raw.githubusercontent.com/victornjie/Story/master/devops.sh"],
            "commandToExecute": "bash devops.sh"
        }
    SETTINGS
  }


}
