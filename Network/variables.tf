variable "resource_group" {
  description = "Resource Group Name"
}

variable "location" {
  default     = "West Europe"
  description = "Resource Location"
}

variable "env_address_prefix" {
  default     = "*"
  description = "Environment's Address Prefix i.e. CIDR"
}

variable "vnet_address_prefix" {
  description = "Address prefix"
}

variable "remote_vnet_ids" {
  type = "list"

  default     = []
  description = "Remote VNet Ids to estatblish VNet Peering with"
}

variable "appgateway_subnet_count" {
  default = 0
}

# Add tag to existing resources
variable "tags" {
    type        = "map"
    description = "Resource Tags"
}