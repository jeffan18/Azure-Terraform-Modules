resource "azurerm_virtual_network" "ms_vnet" {
  name                = "${var.resource_group}-vnet"
  location            = "${var.location}"
  address_space       = ["${var.vnet_address_prefix}"]
  resource_group_name = "${var.resource_group}"

  tags = "${var.tags}"
}

// Establish VNet peerings if remote VNet Ids are provided 
resource "azurerm_virtual_network_peering" "ms_vnet_peering_with_pl_infras" {
  count                        = "${length(var.remote_vnet_ids)}"
  name                         = "${var.resource_group}-vnet-${count.index}"
  resource_group_name          = "${var.resource_group}"
  virtual_network_name         = "${azurerm_virtual_network.ms_vnet.name}"
  remote_virtual_network_id    = "${var.remote_vnet_ids[count.index]}"
  allow_virtual_network_access = "true"
}
