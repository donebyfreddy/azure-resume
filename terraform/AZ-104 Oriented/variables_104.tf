# Azure Subscription
variable "azure_subscription_id" {
  description = "The subscription ID of our Infrastructure"
  type = string
}


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


# Virtual Machines
variable "vm1_name" {
  description = "Name of VM1 IIS-1"
  type        = string
}

variable "vm2_name" {
  description = "Name of VM1 IIS-1"
  type        = string
}

variable "vm_size" {
  description = "Size of both VM'S (Common)"
  type        = string
}

variable "os_disk_caching" {
  description = "OS Disk Caching"
  type        = string
}

variable "os_disk_managed_disk_type" {
  description = "OS Disk Managed type"
  type        = string
}

variable "source_image_ref" {
  description = "Reference IIS Image VM Gallery"
  type        = string
}



# Networking
variable "iis_subnet_name" {
  description = "Name of the subnet which contains the IIS VM'S"
  type        = string
}

variable "subnet_address_prefix" {
  description = "Prefix address of IIS subnet"
  type        = list(string)
}

variable "iis_vnet_name" {
  description = "Name of the VNET which contains IIS"
  type        = string
}

variable "vnet_address_space" {
  description = "VNET Space address of IIS Infrastructure"
  type        = list(string)
}

variable "iis1_nic_name" {
  description = "NIC IIS Name"
  type        = string
}


variable "iis2_nic_name" {
  description = "NIC IIS Name"
  type        = string
}


# Load balancer
variable "lb_name" {
  description = "Name of IIS Load Balancer"
  type        = string
}

variable "lb_frontend_name" {
  description = "Frontend Name of IIS Load Balancer"
  type        = string
}

variable "lb_backend_name" {
  description = "Frontend Name of IIS Load Balancer"
  type        = string
}

# Public IP's
variable "vm1_public_ip_name" {
  description = "VM-1 IIS Public IP Name"
  type        = string
}

variable "vm2_public_ip_name" {
  description = "VM-2 IIS Public IP Name"
  type        = string
}

variable "vm_public_ip_allocation_method" {
  description = "VM Public IP Allocation Method"
  type        = string
}



variable "lb_public_ip_name" {
  description = "Name of Public IP Load Balancer"
  type        = string
}


variable "lb_public_ip_allocation_method" {
  description = "Allocation Method Public IP Load Balancer"
  type        = string
}


# Admin credentials
variable "vm_admin_username" {
  type = string
}
variable "vm_admin_password" {
  type = string
}



# Storage Account function App
variable "functiondatafedetest_name" {
  description = "The name of the storage account."
  type        = string
}


variable "functiondatafedetest_kind" {
  description = "The kind of the storage account."
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

variable "key_vault_key_permissions" {
  description = "Permissions of keys "
  type = list(string)
}

variable "key_vault_secret_permissions" {
  type = list(string)
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


