output "azurermfunctionappId" {
	value="${azurerm_function_app.functionapp.id}"
}

output "outbound_ip_addresses" {
	value="${azurerm_function_app.functionapp.outbound_ip_addresses}"
}
