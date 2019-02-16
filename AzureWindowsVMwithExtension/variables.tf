variable "resource_group_name" {
  type        = "string"
  description = "resource group name"
  default     = "testrg"
}

variable "subnet_id" {
  type 		  = "string"
  description = "subnet name"
}

variable "location" {
  type        = "string"
  description = "location"
  default     = "West Europe"
}

variable "virtual_machine_name" {
	default = "ProcessorVM"
	description = "name of virtual machine"
}

variable "vm_username" {
	default = "azureuser"
	description = "Username of VM"
}

variable "vm_password" {
	default = "myPassword"
	description = "Password of VM"
}

variable "deploy_timestamp" {
  type        = "string"
  description = "describe your variable"
}

variable "powershell_settings" {
  type        = "map"
  description = "powershell settings "
}

variable "protected_settings" {
  type        = "map"
  description = "powershell settings"
}

variable "vm_size" {
  default = "Standard_DS3_v2"
  description = "virtual machine size"
}

variable "disk_name" {
	description = "name of the VM disk"
}