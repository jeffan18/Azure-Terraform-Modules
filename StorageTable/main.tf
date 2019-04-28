resource "azurerm_storage_table" "storagetable" {
  count 			   = "${length(var.storage_table_name)}"
  name                 = "${var.storage_table_name[count.index]}"
  resource_group_name  = "${var.resource_group}"
  storage_account_name = "${var.storage_act_name}"
}
