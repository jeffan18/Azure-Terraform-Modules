variable "subscription_id" {}

variable "client_id" {}

variable "client_secret" {}

variable "tenant_id" {}

variable "resource_group_name" {
    description = "Logical containers for a collection of resources that can be treated as one logical instance"
}

variable "location" {
    description = "The region where to deploy the resource/infrastructure (e.g. East US)."  
    default = " East US"
}

variable "virtual_network_name" {}

variable "address_space" {}

variable "subnet_name" {}

variable "subnet_prefix" {}

variable "public_ip_name" {}

variable "network_security_group_name" {}

variable "network_interface_name" {}

variable "ip_configuration_name" {}

variable "ip_allocation_type" {}

variable "virtual_machine_name" {}

variable "computer_name" {}

variable "vm_username" {}

variable "vm_password"{}

variable "vm_size" {}