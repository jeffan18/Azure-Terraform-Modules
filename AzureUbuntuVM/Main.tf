# configure the Microsoft Azure Provider
provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  client_id       = "${var.client_id}"
  client_secret   = "${var.client_secret}"
  tenant_id       = "${var.tenant_id}"
}

# create a resource group
resource "azurerm_resource_group" "rg" {
    name = "${var.resource_group_name}"
    location = "${var.location}"

}

# create a virtual network
resource "azurerm_virtual_network" "vnet" {
    name = "${var.virtual_network_name}"
    address_space = ["${var.address_space}"]
    location = "${azurerm_resource_group.rg.location}"
    resource_group_name = "${azurerm_resource_group.rg.name}"

}

# create subnet
resource "azurerm_subnet" "subnet" {
    name = "${var.subnet_name}"
    resource_group_name = "${azurerm_resource_group.rg.name}"
    virtual_network_name = "${azurerm_virtual_network.vnet.name}"
    address_prefix = "${var.subnet_prefix}"
}

# create public IP
resource "azurerm_public_ip" "pip" {
    name = "${var.public_ip_name}"
    location = "${azurerm_resource_group.rg.location}"
    resource_group_name = "${azurerm_resource_group.rg.name}"
    public_ip_address_allocation = "Dynamic"
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "nsg" {
  name = "${var.network_security_group_name}"  
  location = "${azurerm_resource_group.rg.location}"  
  resource_group_name = "${azurerm_resource_group.rg.name}"

  security_rule {
      name                       = "Allow-HTTPS-Inbound"    
      priority                   = 100    
      direction                  = "Inbound"    
      access                     = "Allow"    
      protocol                   = "Tcp"    
      source_port_range          = "*"    
      destination_port_range     = "443"    
      source_address_prefix      = "*"    
      destination_address_prefix = "*"
  }

  security_rule {
      name                       = "Allow-HTTP-Inbound"    
      priority                   = 200    
      direction                  = "Inbound"    
      access                     = "Allow"    
      protocol                   = "Tcp"    
      source_port_range          = "*"    
      destination_port_range     = "80"    
      source_address_prefix      = "*"    
      destination_address_prefix = "*"
  }

  security_rule {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
}

# create network interface
resource "azurerm_network_interface" "nic" {
    name = "${var.network_interface_name}"
    location = "${azurerm_resource_group.rg.location}"
    resource_group_name = "${azurerm_resource_group.rg.name}"
    network_security_group_id = "${azurerm_network_security_group.nsg.id}"

    ip_configuration {
        name = "${var.ip_configuration_name}"
        subnet_id = "${azurerm_subnet.subnet.id}"
        private_ip_address_allocation = "${var.ip_allocation_type}"
        public_ip_address_id = "${azurerm_public_ip.pip.id}"
    }

}

# create virtual machine
resource "azurerm_virtual_machine" "ubuntuvm" {
    name = "${var.virtual_machine_name}"
    location = "${azurerm_resource_group.rg.location}"
    resource_group_name = "${azurerm_resource_group.rg.name}"
    network_interface_ids = ["${azurerm_network_interface.nic.id}"]
    vm_size = "${var.vm_size}"

    storage_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "16.04-LTS"
        version   = "latest"
    }

    storage_os_disk {
        name              = "myosdisk1"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Premium_LRS"
    }
    os_profile {
        computer_name  = "${var.computer_name}"
        admin_username = "${var.vm_username}"
        admin_password = "${var.vm_password}"
    }

    os_profile_linux_config {
        disable_password_authentication = false
    }
}