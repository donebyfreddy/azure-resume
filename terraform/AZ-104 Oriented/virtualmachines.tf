# Public IP for Load Balancer
resource "azurerm_public_ip" "public_ip" {
  name                = var.lb_public_ip_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = var.lb_public_ip_allocation_method
}

# Public IP for VM 1
resource "azurerm_public_ip" "vm1_public_ip" {
  name                = var.vm1_public_ip_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = var.vm_public_ip_allocation_method
}

# Public IP for VM 2
resource "azurerm_public_ip" "vm2_public_ip" {
  name                = var.vm2_public_ip_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = var.vm_public_ip_allocation_method
}


# Load Balancer
resource "azurerm_lb" "iis_lb" {
  name                = var.lb_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  frontend_ip_configuration {
    name                     = var.lb_frontend_name 
    public_ip_address_id    = azurerm_public_ip.public_ip.id  # Correct usage
  }
}

# Load Balancer Backend Address Pool
resource "azurerm_lb_backend_address_pool" "backendpool" {
  name                = var.lb_backend_name   
  loadbalancer_id     = azurerm_lb.iis_lb.id

  depends_on = [azurerm_lb.iis_lb]
}

# Health Probe
resource "azurerm_lb_probe" "http_probe" {
  name                = "http_probe"
  loadbalancer_id     = azurerm_lb.iis_lb.id

  protocol            = "Http"
  port                = 80  # Change this if your application uses a different port
  request_path        = "/"  # Change this to the health check endpoint if needed
  interval_in_seconds = 5
  number_of_probes    = 2

  depends_on = [azurerm_lb.iis_lb]
}

# Load Balancing Rule
resource "azurerm_lb_rule" "http_rule" {
  name                          = "http_rule"
  #resource_group_name           = azurerm_resource_group.rg.name
  loadbalancer_id               = azurerm_lb.iis_lb.id
  frontend_ip_configuration_name = var.lb_frontend_name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.backendpool.id]
  probe_id                      = azurerm_lb_probe.http_probe.id
  protocol                      = "Tcp"
  frontend_port                 = 80  # The port exposed by the load balancer
  backend_port                  = 80  # The port on the backend VMs
  idle_timeout_in_minutes       = 4
  enable_floating_ip            = false

  depends_on = [azurerm_lb.iis_lb]
}

# Network Interface for VM1
# Network Interface for VM1
resource "azurerm_network_interface" "vm1_nic" {
  name                = var.iis1_nic_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ip_config_iis1"
    subnet_id                     = azurerm_subnet.iis_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Network Interface for VM2
resource "azurerm_network_interface" "vm2_nic" {
  name                = var.iis2_nic_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "ip_config_iis2"
    subnet_id                     = azurerm_subnet.iis_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Virtual Network
resource "azurerm_virtual_network" "iis_vnet" {
  name                = var.iis_vnet_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  address_space = var.vnet_address_space
}

# Subnet
resource "azurerm_subnet" "iis_subnet" {
  name                 = var.iis_subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.iis_vnet.name

  address_prefixes = var.subnet_address_prefix
}

# Windows Virtual Machine 1
resource "azurerm_windows_virtual_machine" "vm1" {
  name                = var.vm1_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = var.vm_size
  admin_username      = var.vm_admin_username
  admin_password      = var.vm_admin_password

  network_interface_ids = [azurerm_network_interface.vm1_nic.id]

  os_disk {
    caching             = var.os_disk_caching
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.os_publisher
    offer     = var.os_offer
    sku       = var.os_sku
    version   = var.os_version
  }
}

# Windows Virtual Machine 2
resource "azurerm_windows_virtual_machine" "vm2" {
  name                = var.vm2_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  size                = var.vm_size
  admin_username      = var.vm_admin_username
  admin_password      = var.vm_admin_password

  network_interface_ids = [azurerm_network_interface.vm2_nic.id]

  os_disk {
    caching             = var.os_disk_caching
    storage_account_type = "Standard_LRS"

  }
  source_image_reference {
    publisher = var.os_publisher
    offer     = var.os_offer
    sku       = var.os_sku
    version   = var.os_version
  }
}
