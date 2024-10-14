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

variable "local_path" {
  description = "The local path to the directory containing files to upload."
  type        = string
  default     = "C:/Users/Federico Mencuccini/Mencuccini Dropbox/Federico Mencuccini/Aplicaciones/Azure Projects/azure-resume/frontend"
}

# Data block to get current client config
data "azurerm_client_config" "current" {}


# Create a Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "resume-resources-2"
  location = "East US"  # Change to your preferred region
}


# Create Storage Account for the Function App
resource "azurerm_storage_account" "resumestorage" {
  name                     = "resumestoragetestfede"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}


resource "azurerm_storage_container" "webstorage" {
  name                  = "web"
  storage_account_name  = azurerm_storage_account.resumestorage.name
  container_access_type = "blob"
}


# Create CosmosDB Account
resource "azurerm_cosmosdb_account" "cosmosdb" {
  name                = "azureresume-db-testfede"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"
  
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
  name                = "AzureResumeTestFede"
  resource_group_name = azurerm_resource_group.rg.name
  account_name        = azurerm_cosmosdb_account.cosmosdb.name
}

# Create CosmosDB Container
resource "azurerm_cosmosdb_sql_container" "cosmosdb_container" {
  name                = "Counter"
  resource_group_name = azurerm_resource_group.rg.name
  account_name        = azurerm_cosmosdb_account.cosmosdb.name
  database_name       = azurerm_cosmosdb_sql_database.cosmosdb_db.name
  partition_key_paths = ["/id"]
}




# Create Key Vault
resource "azurerm_key_vault" "kv" {
  name                = "MyTestingVault-Fede"  # Ensure this name is unique
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = "standard"
  tenant_id           = data.azurerm_client_config.current.tenant_id

  # Set access policies as needed
  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions    = ["Get", "List", "Recover"]
    secret_permissions = ["Get", "Set", "List", "Delete", "Recover"]
  }

}

# Create a secret in the Key Vault
resource "azurerm_key_vault_secret" "cosmos_db_connection_string" {
  name         = "CosmosDbConnectionString"
  value        = "AccountEndpoint=https://azureresume-db-fede.documents.azure.com:443/;AccountKey=JlXL7dpeMSVvdOmxsF2t4UWxblF0vZl3aB4m3ZZssHvpbrLhswPHxa8zeBTyPDTLeE8W4yiHrcDmACDbEBPUjQ==;"
  key_vault_id = azurerm_key_vault.kv.id
}


# Create App Service Plan for the Function App
# Create App Service Plan for the Function App
resource "azurerm_service_plan" "app_plan" {
  name                = "MyTestAppServicePlan"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  os_type             = "Linux"
  sku_name            = "B1"  # Change to a valid SKU like B1, S1, etc.
}


# Create the Linux Web App
resource "azurerm_linux_web_app" "function" {
  name                = "MyTestFunction-TestFede"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_service_plan.app_plan.location
  service_plan_id     = azurerm_service_plan.app_plan.id

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME" = "dotnet-isolated"  # Use the correct runtime here
    "AzureWebJobsStorage" = "DefaultEndpointsProtocol=https;AccountName=${azurerm_storage_account.resumestorage.name};AccountKey=${azurerm_storage_account.resumestorage.primary_access_key};EndpointSuffix=core.windows.net"  # Important for Azure Functions
    "CosmosDbConnectionString" = azurerm_key_vault_secret.cosmos_db_connection_string.value  # Reference the Key Vault secret
  }

  site_config {}
}


resource "azurerm_storage_blob" "tamopsblobs" {
  for_each = fileset(path.module, "frontend/*")
 
  name                   = trim(each.key, "frontend/")
  storage_account_name   = azurerm_storage_account.resumestorage.name
  storage_container_name = azurerm_storage_container.webstorage.name
  type                   = "Block"
  source                 = each.key
}


