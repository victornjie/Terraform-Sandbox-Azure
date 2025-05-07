locals {
  # A mapping of tags to assign to the resource
  user_defined_tags = {
    "Environment" : "Demo",
    "Owner" : "VictorMbock"
    "Department" : "Local"
  }

  # A mapping of values to assign to the avd_vm_host module
  rg_vm_name     = "rg-vm-eus2"
  location       = "eastus2"
  //vm_size        = "Standard_D2s_v3"
  //vm_name        = "vm-host"
  admin_username = "PSGAdmin"
  admin_password = data.azurerm_key_vault_secret.admin_password.value
  license_type   = "Windows_Server"
  disk_size_gb   = 128
  os_publisher   = "MicrosoftWindowsServer"
  os_offer       = "WindowsServer"
  os_sku         = "2022-datacenter-g2"
  os_version     = "latest"




  vm = {
    "test-vm-01" = {
      vm_size = "Standard_D2s_v3"
    },

    "test-vm-02" = {
      vm_size = "Standard_D2s_v3"
    },

    "test-vm-03" = {
      vm_size = "Standard_D2s_v3"
    },

    "test-vm-04" = {
      vm_size = "Standard_D2s_v3"
    },

    "test-vm-05" = {
      vm_size = "Standard_D2s_v3"
    },
  }

}


