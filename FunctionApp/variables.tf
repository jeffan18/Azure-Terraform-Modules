variable "resource_group_name" {
	default = "webappresourcegroup"
	description = "resource group name"
 }
 
variable "location" {
	default = "weur"
	description = "location of the resource group"
 }

variable "function_plan_name" {
	default = "functionappplan"
	description = "function App plan name"
 }
 
variable "function_app_name" {
	default = "functionappname"
	description = "function App Name"
}

variable "storage_conn_string" {
	description = "Storage primary connection string"
}

variable "app_settings" {
    type = "map"
    default =   {
      "sampleConnStr1"  = "Default Value 1"
      "sampleConnStr2" =  "Default Value 2"
    }
}

variable "tags" {
    type        = "map"
    description = "Resource Tags"
}
