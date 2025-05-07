resource "azurerm_resource_group" "rg_storage" {
  name     = var.rg_storage_name
  location = var.location

  tags = var.user_defined_tags
}

resource "azurerm_storage_account" "storage" {
  name                            = var.storage_name
  resource_group_name             = azurerm_resource_group.rg_storage.name
  location                        = azurerm_resource_group.rg_storage.location
  account_tier                    = var.storage_account_tier
  account_replication_type        = var.storage_replication_type
  account_kind                    = var.storage_account_kind
  access_tier                     = var.storage_access_tier
  https_traffic_only_enabled      = true
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = true
  shared_access_key_enabled       = true
  public_network_access_enabled   = var.allow_public_access
  is_hns_enabled                  = var.enable_hierarchical_namespace
  nfsv3_enabled                   = var.enable_nfs
  sftp_enabled                    = var.enable_sftp
  large_file_share_enabled        = true

  dynamic "blob_properties" {
    for_each = var.enable_hierarchical_namespace ?  [] : [1]

    content {
      versioning_enabled            = true
      change_feed_enabled           = true
      change_feed_retention_in_days = null

      delete_retention_policy {
        days                     = 15
        permanent_delete_enabled = false
      }

      restore_policy {
        days = 14
      }

      container_delete_retention_policy {
        days = 15
      }
    }
  }

  dynamic "network_rules" {
    for_each = var.enable_nfs == true ? [1] : []

    content {
      default_action = "Deny"
    }
    
  }

  /*blob_properties {
    versioning_enabled            = true
    change_feed_enabled           = true
    change_feed_retention_in_days = null

    delete_retention_policy {
      days                     = 15
      permanent_delete_enabled = false
    }

    restore_policy {
      days = 14
    }

    container_delete_retention_policy {
      days = 15
    }
  }*/

}
