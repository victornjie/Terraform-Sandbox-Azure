# Create Storage Account
module "storage_account" {
  source = "./modules/storage-account"

  for_each = local.str_account

  rg_storage_name               = each.value.resource_group_name
  location                      = each.value.location
  storage_name                  = each.value.storage_name
  allow_public_access           = each.value.allow_public_access
  enable_hierarchical_namespace = each.value.enable_hierarchical_namespace
  enable_nfs                    = each.value.enable_nfs
  enable_sftp                   = each.value.enable_sftp
  storage_account_tier          = each.value.storage_account_tier
  storage_replication_type      = each.value.storage_replication_type
  storage_account_kind          = each.value.storage_account_kind
  storage_access_tier           = each.value.storage_access_tier

  user_defined_tags = local.user_defined_tags

}

# Create Blob Storage Container
resource "azurerm_storage_container" "storage_container" {
  for_each              = local.str_container
  name                  = each.value.name
  storage_account_id    = each.value.storage_account_id
  container_access_type = "private"

  depends_on = [module.storage_account]
}

# Create File Share Storage
resource "azurerm_storage_share" "file_share" {
  for_each           = local.str_share
  name               = each.value.name
  storage_account_id = each.value.storage_account_id
  quota              = each.value.quota
  access_tier        = each.value.access_tier
  enabled_protocol   = each.value.enabled_protocol

  depends_on = [module.storage_account]
}
