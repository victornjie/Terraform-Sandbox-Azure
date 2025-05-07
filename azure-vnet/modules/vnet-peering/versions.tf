terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=4.1.0"
      configuration_aliases = [azurerm.hub]
    }
  }
}