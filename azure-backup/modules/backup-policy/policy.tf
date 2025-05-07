resource "azurerm_resource_group" "rg_restore" {
  name     = "${var.prefix}1"
  location = var.location

  tags = var.user_defined_tags
}

resource "azurerm_backup_policy_vm" "vm_policy" {
  name                = var.vm_policy_name
  resource_group_name = var.resource_group_name
  recovery_vault_name = var.recovery_vault_name

  timezone    = "Eastern Standard Time"
  policy_type = "V2"

  backup {
    frequency = "Daily"
    time      = "20:30"
  }

  retention_daily {
    count = 7
  }

  dynamic "retention_weekly" {
    for_each = var.prod_vault == "true" ? ["apply"] : []
    content {
      count    = 2
      weekdays = ["Sunday"]
    }
  }

  # Only supported when monthly and or yearly retention blocks are specified
  /*tiering_policy {
    archived_restore_point {
      mode = "TierRecommended"
    }
  }*/

  instant_restore_resource_group {
    prefix = var.prefix
  }

  instant_restore_retention_days = 3

}


resource "azurerm_backup_policy_vm_workload" "sql_policy" {
  name                = var.sql_policy_name
  resource_group_name = var.resource_group_name
  recovery_vault_name = var.recovery_vault_name

  workload_type = "SQLDataBase"

  settings {
    time_zone           = "Eastern Standard Time"
    compression_enabled = true
  }

  protection_policy {
    policy_type = "Full"

    backup {
      frequency = "Daily"
      time      = "20:30"
    }

    retention_daily {
      count = 7
    }

    dynamic "retention_weekly" {
      for_each = var.prod_vault == "true" ? ["apply"] : []
      content {
        count    = 2
        weekdays = ["Sunday"]
      }
    }
  }

  protection_policy {
    policy_type = "Log"

    backup {
      frequency_in_minutes = 240
    }

    simple_retention {
      count = 7
    }
  }



}
