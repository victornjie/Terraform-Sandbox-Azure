variable "rg_vmss_name" {
  type        = string
  description = "The name which should be used for this Resource Group"
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

variable "vmss_name" {
  type        = string
  description = "The name of the Linux Virtual Machine Scale Set"
}

variable "vmss_sku" {
  type        = string
  description = "The Virtual Machine SKU for the Scale Set"
  default     = "Standard_D4ds_v5"
}

/*variable "vmss_subnet_id" {
  type        = string
  description = "The ID of the Subnet where this Network Interface should be located in"
}*/

variable "source_image_reference" {
  description = "The Azure Platform Image (OS image) to use for provisioning the Virtual Machine Scale Set"
  type = map(object({
    publisher = string,
    offer     = string,
    sku       = string,
    version   = string
  }))

  default = {
    "source_image1" = {
      publisher = "canonical",
      offer     = "ubuntu-24_04-lts"
      sku       = "server",
      version   = "latest"
    }
  }
}

variable "user_defined_tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource"
}
