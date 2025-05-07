variable "quota" {
  type        = number
  description = "The maximum size of the share, in gigabytes"
  default = 120
}

variable "access_tier" {
  type        = string
  description = "The access tier of the File Share"
  default = "Hot"

  validation {
    condition     = contains(["Hot", "Cool", "TransactionOptimized", "Premium"], var.access_tier)
    error_message = "Allowed values are 'Hot', 'Cool', 'TransactionOptimized', or 'Premium'"
  }
}

variable "enabled_protocol" {
  type        = string
  description = "The protocol used for the share"
  default = "SMB"

  validation {
    condition     = contains(["SMB", "NFS"], var.enabled_protocol)
    error_message = "Allowed values are 'SMB' or 'NFS'"
  }
}