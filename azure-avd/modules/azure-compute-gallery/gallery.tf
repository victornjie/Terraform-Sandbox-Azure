resource "azurerm_shared_image_gallery" "gallery" {
  name                = var.gallery_name
  resource_group_name = var.resource_group_name
  location            = var.location
  description         = "TUHS Shared images and VM Golden images."

  /*sharing {
    permission = "Private"
  }*/

}

resource "azurerm_shared_image" "image" {
  name                = var.image_name
  gallery_name        = azurerm_shared_image_gallery.gallery.name
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = var.image_os_type

  identifier {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
  }
}