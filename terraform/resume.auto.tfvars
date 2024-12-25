# Azure Region and Resource Group
azure_subscription_id               = "<YourSubscriptionId>"
location                            = "westus"
resource_group_name                 = "resume-resources-6"

# Storage Account Function Data
functiondatafedetest_name           = "functiondatafedetest"
functiondatafedetest_kind           = "Storage"

# Storage Account Static Website
storage_account_name                = "resumewebsitefedetest2"
storage_account_tier                = "Standard"
storage_account_replication_type    = "LRS"
storage_account_kind                = "StorageV2"

# Static Website $web container
storage_web_container_name          = "$web"
static_website_index_document       = "index.html"
static_website_error_404_document   = "error.html"

# $web Blob Content
blob_type = "Block"



# Cosmos DB Account
cosmosdb_account_name               = "azureresume-db-testfede2"
cosmosdb_account_offer_type         = "Standard"
cosmosdb_account_kind               = "GlobalDocumentDB"

# Cosmos DB SQL Database
cosmosdb_sql_database_name          = "AzureResumeTestFede"

# Cosmos DB Container
cosmosdb_sql_container_name         = "Counter"

# Key Vault
key_vault_name                      = "MyTestingVault-Fede2"
key_vault_sku_name                  = "standard"
key_vault_key_permissions           = ["Get", "List", "Recover"]
key_vault_secret_permissions        = ["Get", "Set", "List", "Delete", "Recover", "Purge"]

# Key Vault Secret
key_vault_secret_name               = "CosmosDbConnectionString"
key_vault_secret_value              = "PutYourEndpoint-String;"

# APP Service Plan
service_plan_name                   = "MyTestAppServicePlan2"
service_plan_os_type                = "Linux"
service_plan_sku_name               = "Y1"

# Functions APP
function_app_name                   = "MyTestFunction-TestFede2"
function_app_os_type                = "linux"
