output "ai_service_id" {
  description = "The ID of the AI Services Account"
  value       = azurerm_ai_services.ai_service.id
}

output "ai_service_name" {
  description = "The name of the AI Services Account"
  value       = azurerm_ai_services.ai_service.name
}

output "ai_service_subdomain" {
  description = "The subdomain name of the AI Services Account"
  value       = azurerm_ai_services.ai_service.custom_subdomain_name
}

output "ai_service_endpoint" {
  description = "The endpoint used to connect to the AI Services Account"
  value       = azurerm_ai_services.ai_service.endpoint
}