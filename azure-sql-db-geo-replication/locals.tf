locals {
  # A mapping of tags to assign to the resource
  user_defined_tags = {
    "Environment" : "Demo",
    "Owner" : "VictorMbock"
    "Department" : "Local"
  }

  # A mapping of values to assign to the primary database module
  rg_sql_name_primary     = "rg-sql-eus2"
  location_primary        = "eastus2"
  sql_server_name_primary = "vicmbocksql001"
  sql_db_name             = "test_sql_db"
  sql_db_max_size_gb      = "10"
  sql_admin_login         = "PSGAdmin"
  sql_admin_password      = data.azurerm_key_vault_secret.admin_password.value
  azuread_username        = "johndoe"
  azuread_object_id       = "64a78c96-b9ce-4520-bdef-f5bff4a231d2"
  azuread_tenant_id       = "14af6cae-701d-426f-a3fd-22192cced361"
  alerts_email_addresses  = ["test@email.com"]


  # A mapping of values to assign to the secondary database module
  rg_sql_name_secondary     = "rg-sql-cus"
  location_secondary        = "centralus"
  sql_server_name_secondary = "vicmbocksql001cus"

}

