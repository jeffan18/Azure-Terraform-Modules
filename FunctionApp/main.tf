resource "azurerm_app_service_plan" "functionappplan" {
  name                = "${var.function_plan_name}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  kind                = "FunctionApp"
  tags                = "${var.tags}"

  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

resource "azurerm_function_app" "functionapp" {
  name                      = "${var.function_app_name}"
  location                  = "${var.location}"
  resource_group_name       = "${var.resource_group_name}"
  app_service_plan_id       = "${azurerm_app_service_plan.functionappplan.id}"
  storage_connection_string = "${var.storage_conn_string}"
  app_settings              = "${var.app_settings}"
  tags                = "${var.tags}"
}
