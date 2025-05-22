variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the resources"
}

variable "location" {
  type        = string
  description = "The Azure Region where the resources should exist"
  default     = "eastus2"

  validation {
    condition     = contains(["eastus2", "centralus"], var.location)
    error_message = "Allowed values are 'eastus2' or 'centralus'"
  }
}

variable "gallery_name" {
  type        = string
  description = "Specifies the name of the Shared Image Gallery"
}

variable "image_name" {
  type        = string
  description = "Specifies the name of the Shared Image"
}

variable "image_os_type" {
  type        = string
  description = "The type of Operating System present in this Shared Image"
  default     = "Windows"

  validation {
    condition     = contains(["Windows", "Linux"], var.image_os_type)
    error_message = "Allowed values are 'Windows' or 'Linux'"
  }
}

variable "image_publisher" {
  type        = string
  description = "The Publisher Name for this Gallery Image"
}

variable "image_offer" {
  type        = string
  description = "The Offer Name for this Shared Image"
}

variable "image_sku" {
  type        = string
  description = "The Name of the SKU for this Gallery Image"
}
