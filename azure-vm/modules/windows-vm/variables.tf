variable "rg_vm_name" {
  type        = string
  description = "The name of the resource group in which to create the Virtual Machine"
}

variable "location" {
  type        = string
  description = "The Azure Region where the Resource Group should exist"
  default     = "eastus2"

  validation {
    condition     = contains(["eastus2", "centralus"], var.location)
    error_message = "Allowed values are 'eastus2' or 'centralus'"
  }
}

variable "vm_name" {
  type        = string
  description = "The name of the Virtual Machine"
}

variable "computer_name" {
  type        = string
  description = "Specifies the Hostname which should be used for this Virtual Machine"
}

variable "vm_size" {
  type        = string
  description = "Specifies the size of the Virtual Machine"
}

variable "vm_subnet_id" {
  type        = string
  description = "The ID of the Subnet where this Network Interface should be located in"
}

variable "os_publisher" {
  type        = string
  description = "Specifies the publisher of the image used to create the virtual machine"
}

variable "os_offer" {
  type        = string
  description = "Specifies the offer of the image used to create the virtual machine"
}

variable "os_sku" {
  type        = string
  description = "Specifies the SKU of the image used to create the virtual machine"
}

variable "os_version" {
  type        = string
  description = "Specifies the version of the image used to create the virtual machine"
}

/*variable "custom_image_id" {
  type        = string
  description = "Specifies the ID of the Custom Image which the Virtual Machine should be created from"
}*/

variable "admin_username" {
  type        = string
  description = "Specifies the name of the local administrator account"
}

variable "admin_password" {
  type        = string
  description = "Specifies the password of the local administrator account"
}

variable "license_type" {
  type        = string
  description = "Specifies the type of on-premise license (also known as Azure Hybrid Use Benefit)"

  validation {
    condition     = contains(["Windows_Server", "Windows_Client"], var.license_type)
    error_message = "Allowed values are 'Windows_Server' or 'Windows_Client'"
  }
}

variable "disk_size_gb" {
  type        = string
  description = "Specifies the size of the managed disk to create in gigabytes"
  default = "128"
}

variable "storage_account_type" {
  type        = string
  description = "The type of storage to use for the managed disk"
  default = "Premium_LRS"

  validation {
    condition     = contains(["Premium_LRS", "PremiumV2_LRS", "StandardSSD_LRS"], var.storage_account_type)
    error_message = "Allowed values are 'Premium_LRS', 'PremiumV2_LRS', or 'StandardSSD_LRS'"
  }
}

variable "user_defined_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource"
}