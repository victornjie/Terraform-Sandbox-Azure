resource "azurerm_monitor_action_group" "action_group" {
  name                = var.action_group_name
  resource_group_name = var.resource_group_name
  short_name          = var.action_group_short_name
  enabled = true

  email_receiver {
    name                    = var.email_receiver_name
    email_address           = var.email_address
    use_common_alert_schema = true
  }

  sms_receiver {
    name         = var.sms_receiver_name
    country_code = "1"
    phone_number = var.phone_number
  }

}

resource "azurerm_monitor_action_group" "email_database" {
  name                = "tuhs-database-alert-group"
  resource_group_name = azurerm_resource_group.example.name
  short_name          = "database-team"

  email_receiver {
    name                    = "email-database"
    email_address           = "devops@contoso.com"
    use_common_alert_schema = true
  }

  sms_receiver {
    name         = "sms-database"
    country_code = "1"
    phone_number = "1231231234"
  }

}

resource "azurerm_monitor_action_group" "email_platform" {
  name                = "tuhs-platform-alert-group"
  resource_group_name = azurerm_resource_group.example.name
  short_name          = "platform-team"

  email_receiver {
    name                    = "email-platform"
    email_address           = "devops@contoso.com"
    use_common_alert_schema = true
  }

  sms_receiver {
    name         = "sms-platform"
    country_code = "1"
    phone_number = "1231231234"
  }

}