resource "azurerm_public_ip" "pip" {
  name                         = "${var.virtual_machine_name}-pubip"
  location                     = "${var.location}"
  resource_group_name          = "${var.resource_group_name}"
  public_ip_address_allocation = "Dynamic"
}

resource "azurerm_network_interface" "nic" {
  name                = "${var.virtual_machine_name}-nic"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  ip_configuration {
    name                          = "${var.virtual_machine_name}-ipconfig"
    subnet_id                     = "$var.subnet_id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = "${azurerm_public_ip.pip.id}"
  }
}

resource "azurerm_virtual_machine" "vm" {
  name                  = "${var.virtual_machine_name}"
  location              = "${var.location}"
  resource_group_name   = "${var.resource_group_name}"
  network_interface_ids = ["${azurerm_network_interface.nic.id}"]
  vm_size               = "${var.vm_size}"

  storage_image_reference {
   publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${var.disk_name}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
	managed_disk_type = "Standard_LRS"
  }
  

  os_profile {
    computer_name  = "${var.virtual_machine_name}"
    admin_username = "${var.vm_username}"
    admin_password = "${var.vm_password}"
  }

  os_profile_windows_config {
    enable_automatic_upgrades = true
    provision_vm_agent = true 
  }
}

## installing packages on VM 
resource "azurerm_virtual_machine_extension" "install_script" {

  name                 = "windows-vm-extn-${var.virtual_machine_name}"
  location             = "${var.location}"
  resource_group_name  = "${var.resource_group_name}"
  virtual_machine_name = "${var.virtual_machine_name}"
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"

  settings = <<SETTINGS
  {
  "fileUris": ["${var.powershell_settings["fileUris"]}"],
    "commandToExecute": "${var.powershell_settings["commandToExecute"]}",
    "timestamp": "${var.deploy_timestamp}"
  }
SETTINGS

  protected_settings = <<SETTINGS
  {
  "storageAccountName": "${var.protected_settings["storageAccountName"]}",
  "storageAccountKey": "${var.protected_settings["storageAccountKey"]}"
  }
SETTINGS

  depends_on = ["azurerm_virtual_machine.vm"]
}