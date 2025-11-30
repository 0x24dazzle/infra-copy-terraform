variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
}

variable "vnet_name" {
  description = "The name of the virtual network"
  type        = string
}

variable "vnet_address_space" {
  description = "The address space for the virtual network"
  type        = list(string)
}

variable "postgresql_subnet_name" {
  description = "The name of the subnet for PostgreSQL"
  type        = string
}

variable "postgresql_subnet_address_prefixes" {
  description = "The address prefixes for the PostgreSQL subnet"
  type        = list(string)
}

variable "postgresql_nsg_name" {
  description = "The name of the network security group for PostgreSQL"
  type        = string
}

variable "allowed_source_address_prefix" {
  description = "Source address prefix allowed to access PostgreSQL"
  type        = string
  default     = "10.0.0.0/16"
}

variable "servicebus_namespace_name" {
  description = "The name of the Service Bus namespace"
  type        = string
}

variable "servicebus_sku" {
  description = "The SKU for the Service Bus namespace (Basic, Standard, Premium)"
  type        = string
  default     = "Standard"
}

variable "servicebus_queue_name" {
  description = "The name of the Service Bus queue"
  type        = string
}

variable "servicebus_queue_enable_partitioning" {
  description = "Enable partitioning for the Service Bus queue"
  type        = bool
  default     = false
}

variable "postgresql_server_name" {
  description = "The name of the PostgreSQL server"
  type        = string
}

variable "postgresql_version" {
  description = "The PostgreSQL version"
  type        = string
  default     = "14"
}

variable "postgresql_admin_login" {
  description = "The administrator login for PostgreSQL"
  type        = string
  sensitive   = true
}

variable "postgresql_admin_password" {
  description = "The administrator password for PostgreSQL"
  type        = string
  sensitive   = true
}

variable "postgresql_zone" {
  description = "The availability zone for PostgreSQL server"
  type        = string
  default     = "1"
}

variable "postgresql_backup_retention_days" {
  description = "Backup retention days for PostgreSQL"
  type        = number
  default     = 7
}

variable "postgresql_geo_redundant_backup_enabled" {
  description = "Enable geo-redundant backup for PostgreSQL"
  type        = bool
  default     = false
}

variable "postgresql_sku_name" {
  description = "The SKU name for PostgreSQL (e.g., B_Standard_B1ms, GP_Standard_D2s_v3)"
  type        = string
}

variable "postgresql_storage_mb" {
  description = "The storage size in MB for PostgreSQL"
  type        = number
  default     = 32768
}

variable "postgresql_private_dns_zone_name" {
  description = "The name of the private DNS zone for PostgreSQL"
  type        = string
}

variable "postgresql_private_dns_zone_vnet_link_name" {
  description = "The name of the virtual network link for PostgreSQL private DNS zone"
  type        = string
}

variable "postgresql_database_name" {
  description = "The name of the PostgreSQL database"
  type        = string
}

variable "postgresql_database_charset" {
  description = "The charset for the PostgreSQL database"
  type        = string
  default     = "UTF8"
}

variable "postgresql_database_collation" {
  description = "The collation for the PostgreSQL database"
  type        = string
  default     = "en_US.utf8"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

