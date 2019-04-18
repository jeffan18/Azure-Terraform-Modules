resource "azurerm_subnet" "public_subnet" {
  name                      = "${var.resource_group}-public-subnet"
  virtual_network_name      = "${azurerm_virtual_network.ms_vnet.name}"
  resource_group_name       = "${var.resource_group}"
  address_prefix            = "${cidrsubnet(var.vnet_address_prefix, 4, 0)}"
  network_security_group_id = "${azurerm_network_security_group.public_subnet_sg.id}"
  service_endpoints         = ["Microsoft.Storage", "Microsoft.Sql", "Microsoft.AzureCosmosDB"]
}

resource "azurerm_subnet_network_security_group_association" "public_subnet_sg_association" {
  subnet_id                 = "${azurerm_subnet.public_subnet.id}"
  network_security_group_id = "${azurerm_network_security_group.public_subnet_sg.id}"
}

resource "azurerm_subnet" "management_subnet" {
  name                      = "${var.resource_group}-management-subnet"
  virtual_network_name      = "${azurerm_virtual_network.ms_vnet.name}"
  resource_group_name       = "${var.resource_group}"
  address_prefix            = "${cidrsubnet(var.vnet_address_prefix, 4, 1)}"
  network_security_group_id = "${azurerm_network_security_group.management_subnet_sg.id}"
  service_endpoints         = ["Microsoft.Storage", "Microsoft.Sql", "Microsoft.AzureCosmosDB"]
}

resource "azurerm_subnet_network_security_group_association" "management_subnet_sg_association" {
  subnet_id                 = "${azurerm_subnet.management_subnet.id}"
  network_security_group_id = "${azurerm_network_security_group.management_subnet_sg.id}"
}

# Create a subnet for application gateway
resource "azurerm_subnet" "appgateway_subnet" {
  count                     = "${var.appgateway_subnet_count}"
  name                      = "${var.resource_group}-appgateway-subnet"
  resource_group_name       = "${var.resource_group}"
  virtual_network_name      = "${azurerm_virtual_network.ms_vnet.name}"
  address_prefix            = "${cidrsubnet(var.vnet_address_prefix, 4, 2)}"
  network_security_group_id = "${azurerm_network_security_group.appgateway_subnet_sg.id}"
  service_endpoints         = ["Microsoft.Storage", "Microsoft.Sql", "Microsoft.AzureCosmosDB"]
}

resource "azurerm_subnet_network_security_group_association" "appgateway_subnet_sg_association" {
  count                     = "${var.appgateway_subnet_count}"
  subnet_id                 = "${azurerm_subnet.appgateway_subnet.id}"
  network_security_group_id = "${azurerm_network_security_group.appgateway_subnet_sg.id}"
}