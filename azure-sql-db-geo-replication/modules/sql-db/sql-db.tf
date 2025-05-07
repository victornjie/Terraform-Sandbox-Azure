resource "azurerm_resource_group" "rg_sql" {
  name     = var.rg_sql_name
  location = var.location

  tags = var.user_defined_tags
}

resource "azurerm_mssql_server" "sql_server" {
  name                         = var.sql_server_name
  resource_group_name          = azurerm_resource_group.rg_sql.name
  location                     = azurerm_resource_group.rg_sql.location
  version                      = "12.0"
  administrator_login          = var.sql_admin_login
  administrator_login_password = var.sql_admin_password
  minimum_tls_version          = "1.2"

  azuread_administrator {
    login_username = var.azuread_username
    object_id      = var.azuread_object_id
    tenant_id      = var.azuread_tenant_id

    azuread_authentication_only = false
  }

  connection_policy = "Default"

  depends_on = [azurerm_resource_group.rg_sql]

}

resource "azurerm_mssql_database" "sql_db" {
  name           = var.sql_db_name
  server_id      = azurerm_mssql_server.sql_server.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = var.sql_db_max_size_gb
  sku_name       = var.sql_db_sku_name
  enclave_type   = "VBS"

  create_mode = var.create_mode
  creation_source_database_id = var.creation_source_database_id
  secondary_type = "Geo"

  long_term_retention_policy {
    weekly_retention = "P2W"
  }

  short_term_retention_policy {
    retention_days = 7
  }

  threat_detection_policy {
    state = "Enabled"
    email_account_admins = "Enabled"
    email_addresses = var.alerts_email_addresses
    storage_endpoint = var.alerts_storage_endpoint
    storage_account_access_key = var.alerts_storage_account_access_key

    retention_days = 30
  }

  # prevent the possibility of accidental data loss
  lifecycle {
    prevent_destroy = false
  }

  depends_on = [azurerm_mssql_server.sql_server]
}

resource "azurerm_mssql_firewall_rule" "local_services" {
  name             = "allow-local-services"
  server_id        = azurerm_mssql_server.sql_server.id
  start_ip_address = "10.0.0.0"
  end_ip_address   = "10.255.255.255"

  depends_on = [azurerm_mssql_database.sql_db]
}

resource "azurerm_mssql_firewall_rule" "azure_services" {
  name             = "allow-azure-services"
  server_id        = azurerm_mssql_server.sql_server.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"

  depends_on = [azurerm_mssql_database.sql_db]
}



resource "azurerm_mssql_server_security_alert_policy" "alerts" {
  resource_group_name        = azurerm_resource_group.rg_sql.name
  server_name                = azurerm_mssql_server.sql_server.name
  state                      = "Enabled"
  storage_endpoint           = var.alerts_storage_endpoint
  storage_account_access_key = var.alerts_storage_account_access_key
  retention_days = 30

  email_account_admins = true
  email_addresses = var.alerts_email_addresses


  depends_on = [azurerm_mssql_database.sql_db]
}
