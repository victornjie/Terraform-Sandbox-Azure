variable "rg_sql_name" {
  type        = string
  description = "The name of the resource group in which to create the Microsoft SQL Database"
}

variable "location" {
  type        = string
  description = "The Azure Region where the Resource Group should exist"

  validation {
    condition     = contains(["eastus2", "centralus"], var.location)
    error_message = "Allowed values are 'eastus2' or 'centralus'"
  }
}

variable "sql_server_name" {
  type        = string
  description = "The name of the Microsoft SQL Server"
}

variable "sql_db_name" {
  type        = string
  description = "The name of the MS SQL Database"
}

variable "sql_db_max_size_gb" {
  type        = string
  description = "The max size of the database in gigabytes"
}

variable "sql_db_sku_name" {
  type        = string
  description = "Specifies the name of the SKU used by the database"
  default     = "GP_Gen5_2"

  validation {
    condition     = contains(["GP_Gen5_2", "GP_S_Gen5_2", "BC_Gen5_2"], var.sql_db_sku_name)
    error_message = "Allowed values are 'GP_Gen5_2', 'GP_S_Gen5_2', or 'BC_Gen5_2'"
  }
}

variable "sql_admin_login" {
  type        = string
  description = "Specifies the name of the local sql administrator account"
}

variable "sql_admin_password" {
  type        = string
  description = "Specifies the password of the local sql administrator account"
}

variable "azuread_username" {
  type        = string
  description = "The login username of the Azure AD Administrator of this SQL Server"
}

variable "azuread_object_id" {
  type        = string
  description = "The object id of the Azure AD Administrator of this SQL Server"
}

variable "azuread_tenant_id" {
  type        = string
  description = "The tenant id of the Azure AD Administrator of this SQL Server"
}

variable "create_mode" {
  type        = string
  description = "Specifies the mode of database creation"

  validation {
    condition     = contains(["Default", "Secondary", "Copy"], var.create_mode)
    error_message = "Allowed values are 'Default', 'Secondary', or 'Copy'"
  }
}

variable "creation_source_database_id" {
  type        = string
  description = "The ID of the source database from which to create the new database"
}

variable "alerts_storage_endpoint" {
  type        = string
  description = "Specifies the blob storage endpoint"
}

variable "alerts_storage_account_access_key" {
  type        = string
  description = "Specifies the identifier key of the Threat Detection audit storage account"
}

variable "alerts_email_addresses" {
  type        = list(string)
  description = "Specifies an array of email addresses to which the alert is sent"
}

variable "user_defined_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource"
}