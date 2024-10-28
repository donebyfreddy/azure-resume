# Azure Region and Resource Group
azure_subscription_id               = "720e477a-5ae7-45cb-bf13-65407359372a"
location                            = "westus"
resource_group_name                 = "resume-resources-10"

# Function Data
functiondatafedetest_name           = "functiondatafedetest"
functiondatafedetest_kind           = "Storage"
storage_account_tier                = "Standard"
storage_account_replication_type    = "LRS"
storage_account_kind                = "StorageV2"

# VM'S
vm1_name                            = "IIS-1"       
vm2_name                            = "IIS-2"    
vm_size                             = "Standard_DC1ds_v3"
os_disk_caching                     = "ReadWrite"  
os_disk_managed_disk_type           = "Standard"  
os_offer                            = "MicrosoftWindowsDesktop"
os_publisher                        = "windows-10"
os_sku                              = "pro"
os_version                          = "latest"

# VM CREDENTIALS
vm_admin_username                   = "Federico"
vm_admin_password                   = "ContrasenaDe12Digitos!*"

# Subnet + VNET 
iis_subnet_name                     = "IIS-Subnet"
iis_vnet_name                       = "IIS-VNET"
subnet_address_prefix               = ["10.0.1.0/24"]
vnet_address_space                  = ["10.0.0.0/16"]

# NIC'S 
iis1_nic_name                       = "iis1-nic"
iis2_nic_name                       = "iis2-nic"

# Load balancer
lb_name                             = "LB-IIS"
lb_frontend_name                    = "myFrontendConfigIIS"
lb_backend_name                     = "myIIS_Pool"

# Public IP's
lb_public_ip_name                   = "LB-PublicIP"
lb_public_ip_allocation_method      = "Static"
vm1_public_ip_name                  = "VM1_PublicIP"
vm2_public_ip_name                  = "VM2_PublicIP"
vm_public_ip_allocation_method      = "Dynamic"

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
key_vault_secret_value              = "AccountEndpoint=https://azureresume-db-testfede.documents.azure.com:443/;AccountKey=JlXL7dpeMSVvdOmxsF2t4UWxblF0vZl3aB4m3ZZssHvpbrLhswPHxa8zeBTyPDTLeE8W4yiHrcDmACDbEBPUjQ==;"

# APP Service Plan
service_plan_name                   = "MyTestAppServicePlan2"
service_plan_os_type                = "Linux"
service_plan_sku_name               = "Y1"

# Functions APP
function_app_name                   = "MyTestFunction-TestFede2"
function_app_os_type                = "linux"