output "resource_group_name" {
  description = "The name of the resource group"
  value       = azurerm_resource_group.main.name
}

output "resource_group_location" {
  description = "The location of the resource group"
  value       = azurerm_resource_group.main.location
}

output "servicebus_namespace_name" {
  description = "The name of the Service Bus namespace"
  value       = azurerm_servicebus_namespace.main.name
}

output "servicebus_namespace_primary_connection_string" {
  description = "The primary connection string for the Service Bus namespace"
  value       = azurerm_servicebus_namespace.main.default_primary_connection_string
  sensitive   = true
}

output "servicebus_queue_name" {
  description = "The name of the Service Bus queue"
  value       = azurerm_servicebus_queue.main.name
}

output "postgresql_server_name" {
  description = "The name of the PostgreSQL server"
  value       = azurerm_postgresql_flexible_server.main.name
}

output "postgresql_server_fqdn" {
  description = "The fully qualified domain name of the PostgreSQL server"
  value       = azurerm_postgresql_flexible_server.main.fqdn
}

output "postgresql_database_name" {
  description = "The name of the PostgreSQL database"
  value       = azurerm_postgresql_flexible_server_database.main.name
}

output "vnet_name" {
  description = "The name of the virtual network"
  value       = azurerm_virtual_network.main.name
}

output "vnet_id" {
  description = "The ID of the virtual network"
  value       = azurerm_virtual_network.main.id
}

output "postgresql_subnet_id" {
  description = "The ID of the PostgreSQL subnet"
  value       = azurerm_subnet.postgresql.id
}

