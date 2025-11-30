terraform {
  required_version = ">= 1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# Resource Group
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

# Virtual Network
resource "azurerm_virtual_network" "main" {
  name                = var.vnet_name
  address_space       = var.vnet_address_space
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

# Subnet for PostgreSQL
resource "azurerm_subnet" "postgresql" {
  name                 = var.postgresql_subnet_name
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = var.postgresql_subnet_address_prefixes
  service_endpoints    = ["Microsoft.Storage"]
  
  delegation {
    name = "postgresql-delegation"
    service_delegation {
      name = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}

# Network Security Group for PostgreSQL subnet
resource "azurerm_network_security_group" "postgresql" {
  name                = var.postgresql_nsg_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

# Network Security Rule - Allow PostgreSQL
resource "azurerm_network_security_rule" "postgresql_allow" {
  name                        = "AllowPostgreSQL"
  priority                    = 1000
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "5432"
  source_address_prefix       = var.allowed_source_address_prefix
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.main.name
  network_security_group_name = azurerm_network_security_group.postgresql.name
}

# Associate NSG with PostgreSQL subnet
resource "azurerm_subnet_network_security_group_association" "postgresql" {
  subnet_id                 = azurerm_subnet.postgresql.id
  network_security_group_id = azurerm_network_security_group.postgresql.id
}

# Service Bus Namespace
resource "azurerm_servicebus_namespace" "main" {
  name                = var.servicebus_namespace_name
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = var.servicebus_sku
  
  tags = var.tags
}

# Service Bus Queue (optional - example)
resource "azurerm_servicebus_queue" "main" {
  name         = var.servicebus_queue_name
  namespace_id = azurerm_servicebus_namespace.main.id
  
  enable_partitioning = var.servicebus_queue_enable_partitioning
}

# PostgreSQL Flexible Server
resource "azurerm_postgresql_flexible_server" "main" {
  name                   = var.postgresql_server_name
  resource_group_name    = azurerm_resource_group.main.name
  location               = azurerm_resource_group.main.location
  version                = var.postgresql_version
  delegated_subnet_id    = azurerm_subnet.postgresql.id
  private_dns_zone_id    = azurerm_private_dns_zone.postgresql.id
  administrator_login    = var.postgresql_admin_login
  administrator_password = var.postgresql_admin_password
  zone                   = var.postgresql_zone
  backup_retention_days   = var.postgresql_backup_retention_days
  geo_redundant_backup_enabled = var.postgresql_geo_redundant_backup
  
  sku_name = var.postgresql_sku_name
  
  storage_mb = var.postgresql_storage_mb
  
  tags = var.tags
  
  depends_on = [azurerm_private_dns_zone_virtual_network_link.postgresql]
}

# Private DNS Zone for PostgreSQL
resource "azurerm_private_dns_zone" "postgresql" {
  name                = var.postgresql_private_dns_zone_name
  resource_group_name = azurerm_resource_group.main.name
}

# Private DNS Zone Virtual Network Link
resource "azurerm_private_dns_zone_virtual_network_link" "postgresql" {
  name                  = var.postgresql_private_dns_zone_vnet_link_name
  resource_group_name   = azurerm_resource_group.main.name
  private_dns_zone_name = azurerm_private_dns_zone.postgresql.name
  virtual_network_id    = azurerm_virtual_network.main.id
  registration_enabled  = false
}

# PostgreSQL Database
resource "azurerm_postgresql_flexible_server_database" "main" {
  name      = var.postgresql_database_name
  server_id = azurerm_postgresql_flexible_server.main.id
  charset   = var.postgresql_database_charset
  collation = var.postgresql_database_collation
}

