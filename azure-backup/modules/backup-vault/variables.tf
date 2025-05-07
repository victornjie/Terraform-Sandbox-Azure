variable "rg_vault_name" {
  type        = string
  description = "The Name which should be used for this Resource Group"
}

variable "location" {
  type        = string
  description = "The Azure Region where the Resource Group should exist"
  default     = "EastUS2"

  validation {
    condition     = contains(["EastUS2", "CentralUS"], var.location)
    error_message = "Allowed values are 'EastUS2' or 'CentralUS'"
  }
}

variable "vault_name" {
  type        = string
  description = "Specifies the name of the Recovery Services Vault"
}

variable "immutability" {
  type        = string
  description = "Specifies the name of the Recovery Services Vault"
  default     = "Unlocked"

  validation {
    condition     = contains(["Unlocked", "Locked", "Disabled"], var.immutability)
    error_message = "Allowed values are 'Unlocked' 'Locked', or 'Disabled'"
  }
}

variable "user_defined_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource"
}