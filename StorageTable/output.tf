output "storagetablename" {
	value="${azurerm_storage_table.storagetable.*.name}"
}
