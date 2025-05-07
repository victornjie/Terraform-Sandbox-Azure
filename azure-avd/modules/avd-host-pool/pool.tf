resource "azurerm_resource_group" "rg_pool" {
  name     = var.rg_pool_name
  location = var.location

  tags = var.user_defined_tags
}


resource "azurerm_virtual_desktop_host_pool" "pool" {
  location            = azurerm_resource_group.rg_pool.location
  resource_group_name = azurerm_resource_group.rg_pool.name

  name                     = var.pool_name
  friendly_name            = var.pool_name
  validate_environment     = false
  custom_rdp_properties    = "audiocapturemode:i:1;audiomode:i:0;"
  description              = "${var.pool_name} ${var.pool_type} AVD Host Pool"
  type                     = var.pool_type
  maximum_sessions_allowed = var.maximum_sessions_allowed
  load_balancer_type       = "DepthFirst"
  public_network_access    = "Enabled"
  preferred_app_group_type = "Desktop"
  scheduled_agent_updates {
    enabled = true
    schedule {
      day_of_week = "Saturday"
      hour_of_day = 2
    }
  }

}


resource "azurerm_virtual_desktop_host_pool_registration_info" "registration" {
  hostpool_id     = azurerm_virtual_desktop_host_pool.pool.id
  expiration_date = "2025-04-30T23:40:52Z"
}


resource "azurerm_virtual_desktop_application_group" "desktop" {
  name                = "desktop-app-group"
  location            = azurerm_resource_group.rg_pool.location
  resource_group_name = azurerm_resource_group.rg_pool.name

  type          = "Desktop"
  host_pool_id  = azurerm_virtual_desktop_host_pool.pool.id
  friendly_name = "desktop-app-group"
  description   = "Azure Virtual Desktop application group"
}


resource "azurerm_virtual_desktop_workspace" "workspace" {
  name                = "workspace"
  location            = azurerm_resource_group.rg_pool.location
  resource_group_name = azurerm_resource_group.rg_pool.name

  friendly_name = "workspace"
  description   = "Azure Virtual Desktop workspace"
}


resource "azurerm_virtual_desktop_workspace_application_group_association" "association" {
  workspace_id         = azurerm_virtual_desktop_workspace.workspace.id
  application_group_id = azurerm_virtual_desktop_application_group.desktop.id
}