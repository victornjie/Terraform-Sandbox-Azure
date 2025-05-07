variable "prod_vault" {
  type        = string
  description = "Specifies if the bakcup policy will be applied to a production Recovery Service Vault"
  default     = "false"
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

variable "vm_policy_name" {
  type        = string
  description = "Specifies the name of the Backup Policy"
}

variable "sql_policy_name" {
  type        = string
  description = "Specifies the name of the Backup Policy"
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the policy"
}

variable "prefix" {
  type        = string
  description = "The prefix for the Instant Restore Resource Group name"
}

variable "recovery_vault_name" {
  type        = string
  description = "Specifies the name of the Recovery Services Vault to use"
}

variable "user_defined_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource"
}