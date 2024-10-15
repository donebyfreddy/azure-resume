# Azure Region
variable "location" {
  description = "The Azure Region in which all resources should be created."
  type        = string
}

# Resource Group Name
variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

# Storage Account
variable "storage_account_name" {
  description = "The name of the storage account."
  type        = string
}

variable "storage_account_tier" {
  description = "The storage account tier."
  type        = string
}

variable "storage_account_replication_type" {
  description = "The replication type for the storage account."
  type        = string
}

variable "storage_account_kind" {
  description = "The kind of the storage account."
  type        = string
}

# Static Website
variable "static_website_index_document" {
  description = "The index document for the static website."
  type        = string
}

variable "static_website_error_404_document" {
  description = "The 404 error document for the static website."
  type        = string
}

variable "static_website_source_folder" {
  description = "The local folder containing the static website source."
  type        = string
}

# Storage Container
variable "storage_container_name" {
  description = "The name of the storage container."
  type        = string
}

variable "storage_container_access_type" {
  description = "The access type of the storage container."
  type        = string
}

# Cosmos DB
variable "cosmosdb_account_name" {
  description = "The name of the Cosmos DB account."
  type        = string
}

variable "cosmosdb_account_offer_type" {
  description = "The offer type for the Cosmos DB account."
  type        = string
}

variable "cosmosdb_account_kind" {
  description = "The kind of the Cosmos DB account."
  type        = string
}

# Cosmos DB SQL Database and Container
variable "cosmosdb_sql_database_name" {
    description = "Name of SQL Cosmos DB Database"
    type        = string
}

variable "cosmosdb_sql_container_name" {
    description = "Name of SQL Database Container"
    type        = string 
}

# Key Vault
variable "key_vault_name" {
  description = "The name of the Cosmos DB account."
  type        = string
}

variable "key_vault_sku_name" {
  description = "The offer type for the Cosmos DB account."
  type        = string
}

variable "key_vault_secret_name" {
  description = "Name of CosmosDB ConnectionString Secret"
  type        = string
}

variable "key_vault_secret_value" {
  description = "VALUE of the CosmosDB ConnectionString"
  type        = string
}

# APP Service Plan
variable "service_plan_name" {
  description = "Name of Functions Service Plan"
  type        = string
}

variable "service_plan_os_type" {
  description = "OS Type Service Plan"
  type        = string
}

variable "service_plan_sku_name" {
  description = "SKU-Name Service Plan"
  type        = string 
}

# Functions APP
variable "function_app_name" {
  description = "Name of Functions APP"
  type        = string
}

variable "function_app_os_type" {
  description = "OS Type Functions APP"
  type        = string
}


