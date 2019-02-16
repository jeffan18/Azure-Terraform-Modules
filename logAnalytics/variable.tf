variable "location" {
	default     = "West Europe"
	description = "Resource Location"

}

variable "resource_group_name" {
	description = "Resource Group Name"
}

variable "log_analytics_workspace" {
	default = "loganalytics"
	description = "Log Analytics Workspace Name"
}

variable "pricing_sb" {
    default = "Standalone"
}
