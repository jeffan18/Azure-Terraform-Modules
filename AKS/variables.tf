variable "resource_group_name" {
	default = "webappresourcegroup"
	description = "resource group name"
 }
 
variable "location" {
	default = "weur"
	description = "location of the resource group"
 }

variable "aks_name" {
	default = "aksname"
	description = "Aks cluster name"
 }
 
variable "dns_prefix" {
	default = ""
	description = "DNS name Name"
}

variable "client_id" {
	description = "Client ID for AKS"
 }
 
variable "client_secret" {
	description = "Client Secret for AKS"
}

variable "subscription_id" {
	description = "Subscription ID for AKS"
 }

variable "agentCount" {
	default = "3"
	description = "Agent Count for AKS"
}

variable "enableHttpApplicationRouting" {
  default = false
}

variable "kubernetesVersion" {
	description = "Subscription ID for AKS"
 }
 
variable "agentVMSize" {
	description = "Subscription ID for AKS"
}

variable "team" {
  type = "string"
}

variable "account_name" {
  type = "string"
}

variable "environment" {
  type = "string"
}
