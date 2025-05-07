variable "rg_storage_name" {
  type        = string
  description = "The name of the resource group in which to create the host pool"
}

variable "location" {
  type        = string
  description = "The Azure Region where the Resource Group should exist"

  validation {
    condition     = contains(["eastus2", "centralus"], var.location)
    error_message = "Allowed values are 'eastus2' or 'centralus'"
  }
}

variable "storage_name" {
  type        = string
  description = "Specifies the name of the storage account"
}

variable "allow_public_access" {
  type        = bool
  description = "Specifies whether public network access is enabled"
}

variable "enable_hierarchical_namespace" {
  type        = bool
  description = "Specifies whether to enable Hierarchical Namespace. This should only be set to true if 'storage_account_tier' is set to 'Standard'"
}

variable "enable_nfs" {
  type        = bool
  description = "Specifies whether to enable NFSv3 protocol. This should only be set to true if 'storage_account_tier' is 'Standard' and 'storage_replication_type' is 'LRS'"
}

variable "enable_sftp" {
  type        = bool
  description = "Specifies whether to enable SFTP for the storage account"
}

variable "storage_account_tier" {
  type        = string
  description = "Defines the Tier to use for this storage account"

  validation {
    condition     = contains(["Standard", "Premium"], var.storage_account_tier)
    error_message = "Allowed values are 'Standard' or 'Premium'"
  }
}

variable "storage_replication_type" {
  type        = string
  description = "Defines the type of replication to use for this storage account"

  validation {
    condition     = contains(["LRS", "ZRS", "RAGZRS"], var.storage_replication_type)
    error_message = "Allowed values are 'LRS', 'ZRS', or 'RAGZRS'"
  }
}

variable "storage_account_kind" {
  type        = string
  description = "Defines the Kind of account"

  validation {
    condition     = contains(["StorageV2", "FileStorage"], var.storage_account_kind)
    error_message = "Allowed values are 'StorageV2' or 'FileStorage'"
  }
}

variable "storage_access_tier" {
  type        = string
  description = "Defines the Tier to use for this storage account"

  validation {
    condition     = contains(["Hot", "Cool", "Cold", "Premium"], var.storage_access_tier)
    error_message = "Allowed values are 'Hot', 'Cool', 'Cold', or 'Premium'"
  }
}

variable "user_defined_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource"
}
