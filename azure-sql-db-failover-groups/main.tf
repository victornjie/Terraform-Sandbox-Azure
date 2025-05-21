resource "azurerm_resource_group" "rg_storage" {
  name     = "rg-alerts-sql"
  location = "eastus2"

  tags = local.user_defined_tags
}
resource "azurerm_storage_account" "storage" {
  name                     = "alerts${local.sql_server_name}"
  resource_group_name      = azurerm_resource_group.rg_storage.name
  location                 = azurerm_resource_group.rg_storage.location
  account_tier             = "Standard"
  account_replication_type = "GZRS"
  min_tls_version          = "TLS1_2"

  depends_on = [azurerm_resource_group.rg_storage]
}

module "sql_database_primary" {
  source = "./modules/sql-db-primary"

  rg_sql_name        = local.rg_sql_name_primary
  location           = local.location_primary
  sql_server_name    = "${local.sql_server_name}eus2"
  sql_db_name        = local.sql_db_name
  sql_db_max_size_gb = local.sql_db_max_size_gb
  sql_admin_login    = local.sql_admin_login
  sql_admin_password = local.sql_admin_password
  azuread_username   = local.azuread_username
  azuread_object_id  = local.azuread_object_id
  azuread_tenant_id  = local.azuread_tenant_id

  alerts_storage_endpoint           = azurerm_storage_account.storage.primary_blob_endpoint
  alerts_storage_account_access_key = azurerm_storage_account.storage.primary_access_key
  alerts_email_addresses            = local.alerts_email_addresses

  create_mode                 = "Default"
  creation_source_database_id = null

  user_defined_tags = local.user_defined_tags

  depends_on = [azurerm_storage_account.storage]
}

module "sql_database_secondary" {
  source = "./modules/sql-db-secondary"

  rg_sql_name        = local.rg_sql_name_secondary
  location           = local.location_secondary
  sql_server_name    = "${local.sql_server_name}cus"
  sql_admin_login    = local.sql_admin_login
  sql_admin_password = local.sql_admin_password
  azuread_username   = local.azuread_username
  azuread_object_id  = local.azuread_object_id
  azuread_tenant_id  = local.azuread_tenant_id

  alerts_storage_endpoint           = azurerm_storage_account.storage.primary_blob_endpoint
  alerts_storage_account_access_key = azurerm_storage_account.storage.primary_access_key
  alerts_email_addresses            = local.alerts_email_addresses

  user_defined_tags = local.user_defined_tags

  depends_on = [module.sql_database_primary]
}

resource "azurerm_mssql_failover_group" "failover_group" {
  name      = local.sql_server_name
  server_id = module.sql_database_primary.sql_server_id
  databases = [
    module.sql_database_primary.sql_db_id
  ]

  partner_server {
    id = module.sql_database_secondary.sql_server_id
  }

  #Comment this content block and uncomment the content block below if you want to use Microsoft Managed (Automatic) Failover policy
  read_write_endpoint_failover_policy {
    mode = "Manual"
  }

  #Comment this content block and uncomment the content block above if you want to use Customer Managed (Manual) Failover policy
  /*read_write_endpoint_failover_policy {
    mode          = "Automatic"
    grace_minutes = 60
  }*/

  depends_on = [module.sql_database_secondary]
}

# Create private endpoint for SQL server
resource "azurerm_private_endpoint" "sql_db_primary_endpoint" {
  name                = "sqldb-endpoint"
  location            = local.location_primary
  resource_group_name = local.rg_sql_name_primary
  subnet_id           = data.azurerm_subnet.subnet.id

  private_service_connection {
    name                           = "sql-private-serviceconnection"
    private_connection_resource_id = module.sql_database_primary.sql_server_id
    subresource_names              = ["sqlServer"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = "sql-dns-zone-group"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.sql.id]
  }

  depends_on = [module.sql_database_primary]
}
