output "ai_hub_id" {
  description = "The ID of the AI Foundry Hub"
  value       = azurerm_ai_foundry.ai_hub.id
}

output "ai_hub_name" {
  description = "The name of the AI Foundry Hub"
  value       = azurerm_ai_foundry.ai_hub.name
}

output "ai_hub_workspace_id" {
  description = "The immutable ID associated with this AI Foundry Hub"
  value       = azurerm_ai_foundry.ai_hub.workspace_id
}