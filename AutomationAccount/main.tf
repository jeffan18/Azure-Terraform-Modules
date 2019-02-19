resource "azurerm_automation_account" "autoacc" {
  name                = "${var.automation_acc_name}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  sku {
    name = "${var.sku_name}"
  }
  tags = "${var.tags}"
}