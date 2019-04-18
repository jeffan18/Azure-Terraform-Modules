variable loadbalancer_name {}
variable location {}
variable resource_group_name {}
variable address_allocation {}
variable protocol {}
variable frontend_port_start {}
variable frontend_port_end {}
variable backend_port {}
variable request_path {}
variable request_port {}
variable subnet_id {}
variable "tags" {
    type        = "map"
    description = "Resource Tags"
}