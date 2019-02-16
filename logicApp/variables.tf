variable "resource_group_name" {
	default = "webappresourcegroup"
	description = "resource group name"
 }
 
variable "location" {
	default = "weur"
	description = "location of the resource group"
}

variable "logic_app_name" {
    default = "logicapp"
	description = "Logic app name Name"
}

# Add tag to existing resources
variable "tags" {
    type        = "map"
    description = "Resource Tags"
}

