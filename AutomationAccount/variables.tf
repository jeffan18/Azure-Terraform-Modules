variable "resource_group_name" {
	default = "mdsp-updatemanagement-enable"
	
	description = "resource group name"
 }
 
variable "location" {
	default = "West Europe"
	
	description = "location of the resource group"
 }

variable "automation_acc_name" {
	default = "mdspautomationaccount"
	
	description = "Storage account name"
 }

variable "sku_name" {
	default = "Basic"
	description = "Name of the sku of automation account"
}

variable "tags" {
    default = {
      environment = "Dev"
      team = "Global Infra"
    }
    description = "Resource Tags"
}

