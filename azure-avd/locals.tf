locals {
  # A mapping of tags to assign to the resource
  user_defined_tags = {
    "Environment" : "Demo",
    "Owner" : "VictorMbock"
    "Department" : "Local"
  }

  # A mapping of values to assign to the avd_host_pool module
  rg_pool_name = "rg-avd-host-pool-eus2"
  location     = "eastus2"

  host_pool = {
    "desktop_pool" = {
      pool_type                = "Pooled"
      pool_name                = "desktop-pool"
      maximum_sessions_allowed = 5
    },
    "base_pool" = {
      pool_type                = "Pooled"
      pool_name                = "base-pool"
      maximum_sessions_allowed = 10
    }
  }

  # A mapping of values to assign to the avd_vm_host module
  rg_vm_name = "rg-avd-vm-host-eus2"
  //vm_size           = "Standard_D2s_v3"
  //vm_name           = "vm-host"
  admin_username    = "PSGAdmin"
  admin_password    = data.azurerm_key_vault_secret.admin_password.value
  license_type      = "Windows_Client"
  avd_vm_deployment = true
  os_publisher      = "microsoftwindowsdesktop"
  os_offer          = "windows-11"
  os_sku            = "win11-23h2-pro"
  os_version        = "latest"

  desktop_pool_vm_host = {
    "desktop-host" = {
      vm_size = "Standard_D2s_v3"
      count   = 3
    }
  }

  base_pool_vm_host = {
    "base-host" = {
      vm_size = "Standard_D2s_v3"
      count   = 2
    }
  }

  # A mapping of values to assign to the compute_gallery module
  rg_gallery_name = "rg-compute-gallery-eus2"
  gallery_name    = "test_compute_gallery_eus2"
  image_name      = "test-win11-image-eus2"
  image_os_type   = "Windows"
  image_publisher = "Microsoft"
  image_offer     = "Windows-11"
  image_sku       = "Win11-Pro"

}


