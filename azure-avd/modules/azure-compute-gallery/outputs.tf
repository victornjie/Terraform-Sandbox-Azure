output "gallery_name" {
  description = "The name of the Shared Image Gallery"
  value       = azurerm_shared_image_gallery.gallery.name
}

output "gallery_id" {
  description = "The ID of the Shared Image Gallery"
  value       = azurerm_shared_image_gallery.gallery.id
}

output "image_name" {
  description = "The name of the Shared Image"
  value       = azurerm_shared_image.image.name
}