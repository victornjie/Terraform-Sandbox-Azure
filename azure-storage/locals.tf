locals {
  # A mapping of tags to assign to the resource
  user_defined_tags = {
    "Environment" : "Demo",
    "Owner" : "VictorMbock"
    "Department" : "Local"
  }


  # A mapping of values to assign to the resource

  str_account = {
    "str_account_001" = {
      resource_group_name           = "rg-str-account-eus2-001"
      location                      = "eastus2"
      storage_name                  = "vicstraccounteus2001"
      allow_public_access           = true
      enable_hierarchical_namespace = false
      enable_nfs                    = false
      enable_sftp                   = false
      storage_account_tier          = "Standard"
      storage_replication_type      = "RAGZRS"
      storage_account_kind          = "StorageV2"
      storage_access_tier           = "Cool"
    },

    "str_account_002" = {
      resource_group_name           = "rg-str-account-cus-001"
      location                      = "centralus"
      storage_name                  = "vicstraccountcus001"
      allow_public_access           = true
      enable_hierarchical_namespace = true
      enable_nfs                    = true
      enable_sftp                   = true
      storage_account_tier          = "Standard"
      storage_replication_type      = "LRS"
      storage_account_kind          = "StorageV2"
      storage_access_tier           = "Hot"
    }

    /*"str_account_003" = {
      resource_group_name           = "rg-str-account-eus2-002"
      location                      = "eastus2"
      storage_name                  = "vicstraccounteus2002"
      allow_public_access           = false
      enable_hierarchical_namespace = false
      enable_nfs                    = false
      enable_sftp                   = false
      storage_account_tier          = "Premium"
      storage_replication_type      = "ZRS"
      storage_account_kind          = "FileStorage"
      storage_access_tier           = "Hot"
    }*/
  }

  str_container = {
    "str_container_001" = {
      name               = "prod-container"
      storage_account_id = module.storage_account["str_account_001"].storage_account_id
    },

    "str_container_002" = {
      name               = "dev-container"
      storage_account_id = module.storage_account["str_account_001"].storage_account_id
    },

    "str_container_003" = {
      name               = "nfs-container"
      storage_account_id = module.storage_account["str_account_002"].storage_account_id
    }
  }

  str_share = {
    "str_share_001" = {
      name               = "prod-share"
      storage_account_id = module.storage_account["str_account_001"].storage_account_id
      quota              = 5
      access_tier        = "Hot"
      enabled_protocol   = "SMB"
    }

    /*"str_share_002" = {
      name               = "nfs-share"
      storage_account_id = module.storage_account["str_account_003"].storage_account_id
      quota              = 110
      access_tier        = "Premium"
      enabled_protocol   = "NFS"
    },

    "str_share_003" = {
      name               = "smb-share"
      storage_account_id = module.storage_account["str_account_003"].storage_account_id
      quota              = 110
      access_tier        = "TransactionOptimized"
      enabled_protocol   = "SMB"
    }*/
  }

}
