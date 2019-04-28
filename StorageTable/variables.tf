variable "resource_group" {
	default = "storageaccountrg"
	
	description = "resource group name"
}
 
variable "storage_act_name" {
	default = "rjstorageaccount"
	
	description = "Storage account name"
}

variable "storage_table_name" {
  type = "list"
  default = ["myfirsttable", "mysecondtable"]
  description = "describe your variable"
}
