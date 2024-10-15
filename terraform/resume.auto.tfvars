# Azure Region and Resource Group
location             = "westus"
resource_group_name  = "resume-resources-5"

# Storage Account
storage_account_name            = "resumewebsite"
storage_account_tier            = "Standard"
storage_account_replication_type = "LRS"
storage_account_kind            = "StorageV2"

# Static Website
static_website_index_document   = "index.html"
static_website_error_404_document = "error.html"
static_website_source_folder    = "../frontend"

# Storage Container
storage_container_name          = "$web"
storage_container_access_type   = "blob"

# Cosmos DB Account
cosmosdb_account_name           = "azureresume-db-testfede"
cosmosdb_account_offer_type     = "Standard"
cosmosdb_account_kind           = "GlobalDocumentDB"

# Cosmos DB SQL Database
cosmosdb_sql_database_name      = "AzureResumeTestFede"

# Cosmos DB Container
cosmosdb_sql_container_name     = "Counter"

# Key Vault
key_vault_name           = "MyTestingVault-Fede"
key_vault_sku_name       = "standard"

# Key Vault Secret
key_vault_secret_name    = "CosmosDbConnectionString"
key_vault_secret_value   = "AccountEndpoint=https://azureresume-db-testfede.documents.azure.com:443/;AccountKey=JlXL7dpeMSVvdOmxsF2t4UWxblF0vZl3aB4m3ZZssHvpbrLhswPHxa8zeBTyPDTLeE8W4yiHrcDmACDbEBPUjQ==;"

# APP Service Plan
service_plan_name        = "MyTestAppServicePlan"
service_plan_os_type     = "Linux"
service_plan_sku_name    = "Y1"

# Functions APP
function_app_name        = "MyTestFunction-TestFede"
function_app_os_type     = "linux"