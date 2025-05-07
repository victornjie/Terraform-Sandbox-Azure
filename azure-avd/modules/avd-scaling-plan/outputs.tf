output "scaling_plan_id" {
  description = "The ID of the Scaling Plan"
  value       = azurerm_virtual_desktop_scaling_plan.scaling_plan.id
}

output "scaling_plan_name" {
  description = "The name of the Scaling Plan"
  value       = azurerm_virtual_desktop_scaling_plan.scaling_plan.name
}