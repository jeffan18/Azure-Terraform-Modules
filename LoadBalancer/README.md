
```
module "load_balancer" {
  source = "git::ssh://git@load-balancer.git"

  // Parameters
  loadbalancer_name   = "${module.resource_group.name}-ilb"
  location            = "${var.location}"
  resource_group_name = "${module.resource_group.name}"
  address_allocation  = "${var.address_allocation}"
  protocol            = "${var.protocol}"
  frontend_port_start = "${var.frontend_port_start}"
  frontend_port_end   = "${var.frontend_port_end}"
  backend_port        = "${var.backend_port}"
  request_path        = "${var.request_path}"
  request_port        = "${var.request_port}"
  subnet_id           = "${module.network.management_subnet_id}"
}
```
