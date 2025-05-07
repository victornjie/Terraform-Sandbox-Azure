resource "azurerm_resource_group" "rg_monitor" {
  name     = local.rg_monitor_name
  location = local.location

  tags = local.user_defined_tags
}

module "vm_monitor" {
  source = "./modules/vm-monitor"

  resource_group_name      = azurerm_resource_group.rg_monitor.name
  monitor_alert_scope      = local.monitor_alert_scope
  email_address            = local.email_address
  phone_number             = local.phone_number
  target_resource_location = local.location
  vm_metric_alert          = local.vm_metric_alert

  depends_on = [azurerm_resource_group.rg_monitor]
}
