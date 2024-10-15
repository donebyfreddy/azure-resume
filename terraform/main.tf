terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "720e477a-5ae7-45cb-bf13-65407359372a"
  resource_provider_registrations = "none"
}


# Data block to get current client config
data "azurerm_client_config" "current" {}


# Create a Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}


# Create Storage Account for the Function App
resource "azurerm_storage_account" "resumestoragetestfede" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_account_replication_type
  account_kind             = var.storage_account_kind

  static_website {
    index_document = var.static_website_index_document
  }
}


resource "azurerm_storage_container" "webstorage" {
  name                  = var.storage_container_name
  storage_account_name  = azurerm_storage_account.resumestoragetestfede.name
  container_access_type = var.storage_container_access_type

  depends_on = [azurerm_storage_account.resumestoragetestfede]
}


# Create CosmosDB Account
resource "azurerm_cosmosdb_account" "cosmosdb" {
  name                = var.cosmosdb_account_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  offer_type          = var.cosmosdb_account_offer_type
  kind                = var.cosmosdb_account_kind
  
  consistency_policy {
    consistency_level = "Session"
  }
  
  geo_location {
    location          = azurerm_resource_group.rg.location
    failover_priority = 0  # Primary location
  }
}

# Create CosmosDB Database
resource "azurerm_cosmosdb_sql_database" "cosmosdb_db" {
  name                = var.cosmosdb_sql_database_name
  resource_group_name = azurerm_resource_group.rg.name
  account_name        = azurerm_cosmosdb_account.cosmosdb.name


}

# Create CosmosDB Container
resource "azurerm_cosmosdb_sql_container" "cosmosdb_container" {
  name                = var.cosmosdb_sql_container_name
  resource_group_name = azurerm_resource_group.rg.name
  account_name        = azurerm_cosmosdb_account.cosmosdb.name
  database_name       = azurerm_cosmosdb_sql_database.cosmosdb_db.name
  partition_key_paths = ["/id"]

}




# Create Key Vault
resource "azurerm_key_vault" "kv" {
  name                = var.key_vault_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = var.key_vault_sku_name
  tenant_id           = data.azurerm_client_config.current.tenant_id

  # Set access policies as needed
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions    = ["Get", "List", "Recover"]
    secret_permissions = ["Get", "Set", "List", "Delete", "Recover", "Purge"]
  }

}

# Create a secret in the Key Vault
resource "azurerm_key_vault_secret" "cosmos_db_connection_string" {
  name         = var.key_vault_secret_name
  value        = var.key_vault_secret_value
  key_vault_id = azurerm_key_vault.kv.id

}


# Create App Service Plan for the Function App
resource "azurerm_service_plan" "app_plan" {
  name                = var.service_plan_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = var.service_plan_os_type
  sku_name            = var.service_plan_sku_name

}

# Create the Function App
resource "azurerm_function_app" "function" {
  name                = var.function_app_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_service_plan.app_plan.location
  app_service_plan_id     = azurerm_service_plan.app_plan.id
  storage_account_name   = azurerm_storage_account.resumestoragetestfede.name
  storage_account_access_key = azurerm_storage_account.resumestoragetestfede.primary_access_key
  os_type             = var.function_app_os_type

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME" = "dotnet-isolated"  # Use the correct runtime here
    "AzureWebJobsStorage" = "DefaultEndpointsProtocol=https;AccountName=${azurerm_storage_account.resumestoragetestfede.name};AccountKey=${azurerm_storage_account.resumestoragetestfede.primary_access_key};EndpointSuffix=core.windows.net"
    "CosmosDbConnectionString" = azurerm_key_vault_secret.cosmos_db_connection_string.value
  }

  site_config {
    cors {
      allowed_origins = [
        "${azurerm_storage_account.resumestoragetestfede.primary_web_endpoint}"
      ]
    }
  }

  depends_on = [
    azurerm_storage_account.resumestoragetestfede,
    azurerm_key_vault.kv
  ]
}



