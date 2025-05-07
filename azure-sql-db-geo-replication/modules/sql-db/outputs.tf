output "sql_server_id" {
  description = "The ID of the Microsoft SQL Server"
  value       = azurerm_mssql_server.sql_server.id
}

output "sql_server_fqdn" {
  description = "The fully qualified domain name of the Azure SQL Server"
  value       = azurerm_mssql_server.sql_server.fully_qualified_domain_name
}

output "sql_db_name" {
  description = "The name of the MS SQL Database"
  value       = azurerm_mssql_database.sql_db.name
}

output "sql_db_id" {
  description = "The ID of the MS SQL Database"
  value       = azurerm_mssql_database.sql_db.id
}