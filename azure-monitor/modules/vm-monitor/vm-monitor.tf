resource "azurerm_monitor_action_group" "ops_action_group" {
  name                = "tuhs-ops-alert-group"
  resource_group_name = var.resource_group_name
  short_name          = "ops-team"
  enabled             = true

  email_receiver {
    name                    = "email-ops-team"
    email_address           = var.email_address
    use_common_alert_schema = true
  }

  sms_receiver {
    name         = "sms-ops-team"
    country_code = "1"
    phone_number = var.phone_number
  }
}

resource "azurerm_monitor_action_group" "automation_action_group" {
  name                = "tuhs-automation-alert-group"
  resource_group_name = var.resource_group_name
  short_name          = "automation"
  enabled             = true

}

resource "azurerm_monitor_metric_alert" "vm" {
  for_each                 = var.vm_metric_alert
  name                     = each.key
  resource_group_name      = var.resource_group_name
  scopes                   = var.monitor_alert_scope
  description              = each.value.description
  target_resource_type     = "Microsoft.Compute/virtualMachines"
  target_resource_location = var.target_resource_location

  frequency   = "PT1M"
  window_size = "PT5M"

  auto_mitigate = false
  severity      = 3

  criteria {
    metric_namespace = "Microsoft.Compute/virtualMachines"
    metric_name      = each.value.metric_name
    aggregation      = each.value.aggregation
    operator         = each.value.operator
    threshold        = each.value.threshold

    /*dimension {
      name     = "ApiName"
      operator = "Include"
      values   = ["*"]
    }*/
  }

  action {
    action_group_id = azurerm_monitor_action_group.ops_action_group.id
  }

  action {
    action_group_id = azurerm_monitor_action_group.automation_action_group.id
  }
}
