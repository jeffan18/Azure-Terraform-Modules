## network security group
resource "azurerm_network_security_group" "private_subnet_sg" {
  name                = "${var.virtual_machine_scale_set_name}-private-subnet-sg"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  tags                = "${var.tags}"

  security_rule {
    name                       = "Deny-All-Outbound"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Deny"
    protocol                   = "Any"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
    description                = "Block All ports of all protocol"
  }
}

## subnet
resource "azurerm_subnet" "private_subnet" {
  name                      = "${var.virtual_machine_scale_set_name}-private-subnet"
  virtual_network_name      = "${var.virtual_network_name}"
  resource_group_name       = "${var.resource_group_name}"
  address_prefix            = "${var.vnet_address_prefix}"
  network_security_group_id = "${azurerm_network_security_group.private_subnet_sg.id}"
}

## network nterface

resource "azurerm_network_interface" "nic" {
  name                = "${var.virtual_machine_scale_set_name}-nic"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  tags                = "${var.tags}"

  ip_configuration {
    name                          = "${var.virtual_machine_scale_set_name}-ipconfig"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "Dynamic"
  }
}

## loadbalancer

resource "azurerm_lb" "lb" {
  name                = "${var.virtual_machine_scale_set_name}-lb"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  tags                = "${var.tags}"

  frontend_ip_configuration {
    name                          = "PublicIPAddress"
    subnet_id                     = ""
    private_ip_address_allocation = ""
  }
}

resource "azurerm_lb_backend_address_pool" "bpepool" {
  resource_group_name = "${var.resource_group_name}"
  loadbalancer_id     = "${azurerm_lb.lb.id}"
  name                = "BackEndAddressPool"
  
}

resource "azurerm_lb_nat_pool" "lbnatpool" {
  count                          = 3
  resource_group_name            = "${var.resource_group_name}"
  name                           = "ssh"
  loadbalancer_id                = "${azurerm_lb.lb.id}"
  protocol                       = "Tcp"
  frontend_port_start            = 50000
  frontend_port_end              = 50119
  backend_port                   = 22
  frontend_ip_configuration_name = "PublicIPAddress"
}

resource "azurerm_lb_probe" "lb_probe" {
  resource_group_name = "${var.resource_group_name}"
  loadbalancer_id     = "${azurerm_lb.lb.id}"
  name                = "http-probe"
  request_path        = "/health"
  port                = 8080
}

resource "azurerm_virtual_machine_scale_set" "vmss" {
  name                = "${var.virtual_machine_scale_set_name}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  tags                = "${var.tags}"

  # automatic rolling upgrade
  automatic_os_upgrade = true
  upgrade_policy_mode  = "Rolling"

  rolling_upgrade_policy {
    max_batch_instance_percent              = 20
    max_unhealthy_instance_percent          = 20
    max_unhealthy_upgraded_instance_percent = 5
    pause_time_between_batches              = "PT0S"
  }

  # required when using rolling upgrade policy
  health_probe_id = "${azurerm_lb_probe.lb_probe.id}"

  sku {
    name     = "${var.sku_name}"
    tier     = "${var.sku_tier}"
    capacity = "${var.sku_capacity}"
  }

  storage_profile_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_profile_os_disk {
    name              = ""
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_profile_data_disk {
    lun           = 0
    caching       = "ReadWrite"
    create_option = "Empty"
    disk_size_gb  = 10
  }

  os_profile {
    computer_name_prefix = "${var.hostname}"
    admin_username       = "${var.admin_username}"
    admin_password       = "${var.admin_password}"
  }

  boot_diagnostics {
    enabled     = true
    storage_uri = ""
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/${var.admin_username}/.ssh/authorized_keys"
      key_data = "${file("~/.ssh/demo_key.pub")}"
    }
  }

  network_profile {
    name    = "${var.hostname}-networkprofile"
    primary = true

    ip_configuration {
      name                                   = "${var.hostname}-IPConfiguration"
      primary                                = true
      subnet_id                              = "${var.subnet_id}"
      load_balancer_backend_address_pool_ids = ["${azurerm_lb_backend_address_pool.bpepool.id}"]
      load_balancer_inbound_nat_rules_ids    = ["${element(azurerm_lb_nat_pool.lbnatpool.*.id, count.index)}"]
    }
  }
}


resource "azurerm_virtual_machine_extension" "install_script" {
  name                 = "${var.virtual_machine_scale_set_name}-installation"
  location             = "${var.location}"
  resource_group_name  = "${var.resource_group_name}"
  virtual_machine_name = "${azurerm_virtual_machine_scale_set.vmss.name}"
  publisher            = "Microsoft.OSTCExtensions"
  type                 = "CustomScriptForLinux"
  type_handler_version = "1.5"
  tags                 = "${var.tags}"

  settings = <<SETTINGS
  {
  "fileUris": ["${var.shell_settings["fileUris"]}"],
    "commandToExecute": "${var.shell_settings["commandToExecute"]}",
    "timestamp": "${var.deploy_timestamp}"
  }
SETTINGS

  protected_settings = <<SETTINGS
  {
  "storageAccountName": "${var.protected_settings["storageAccountName"]}",
  "storageAccountKey": "${var.protected_settings["storageAccountKey"]}"
  }
SETTINGS

  depends_on = ["azurerm_virtual_machine_scale_set.vmss"]
}
