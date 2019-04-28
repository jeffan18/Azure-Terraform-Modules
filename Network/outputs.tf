output "vnet_id" {
  value = "${azurerm_virtual_network.ms_vnet.id}"
}

output "vnet_name" {
  value = "${azurerm_virtual_network.ms_vnet.name}"
}

output "vnet_resource_group_name" {
  value = "${azurerm_virtual_network.ms_vnet.resource_group_name}"
}

output "public_subnet_id" {
  value = "${azurerm_subnet.public_subnet.id}"
}

output "public_subnet_name" {
  value = "${azurerm_subnet.public_subnet.name}"
}

output "management_subnet_id" {
  value = "${azurerm_subnet.management_subnet.id}"
}

output "management_subnet_name" {
  value = "${azurerm_subnet.management_subnet.name}"
}

## TODO  https://code.siemens.com/mindsphere-azure/infrastructure_az/terraform_modules/network/issues/1
# output "appgateway_subnet_id" {
#   value = "${azurerm_subnet.appgateway_subnet.id}"
# }

# output "appgateway_subnet_name" {
#   value = "${azurerm_subnet.appgateway_subnet.name}"
# }

output "vnet_address_prefix" {
  value = "${var.vnet_address_prefix}"
}

output "management_subnet_prefix" {
  value = "${azurerm_subnet.management_subnet.address_prefix}"
}

output "public_subnet_prefix" {
  value = "${azurerm_subnet.public_subnet.address_prefix}"
}
