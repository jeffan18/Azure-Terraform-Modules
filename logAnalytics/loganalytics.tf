resource "azurerm_log_analytics_workspace" "loganalytics" {
  name                = "my_log_analytics_workspace"
  location            = "${azurerm_resource_group.test.location}"
  resource_group_name = "${azurerm_resource_group.test.name}"
  sku                 = "Standalone"
  retention_in_days   = 30
}