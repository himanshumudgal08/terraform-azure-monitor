
output "action_group_id" {
  description = "Id of the action group."
  value       = azurerm_monitor_action_group.main.id
}

output "azurerm_monitor_action_group_id" {
  description = "The ID of monitor action group"
  value       = azurerm_monitor_action_group.main.id
}
