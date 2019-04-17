## loadbalancer

resource "azurerm_lb" "lb" {
  name                = "${var.loadbalancer_name}"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"

  frontend_ip_configuration {
    name                          = "${var.loadbalancer_name}-IP"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "${var.address_allocation}"
  }
  tags = "${var.tags}"
}

resource "azurerm_lb_backend_address_pool" "bekpool" {
  resource_group_name = "${var.resource_group_name}"
  loadbalancer_id     = "${azurerm_lb.lb.id}"
  name                = "${var.loadbalancer_name}-bekpool"
}

resource "azurerm_lb_probe" "lb_probe" {
  resource_group_name = "${var.resource_group_name}"
  loadbalancer_id     = "${azurerm_lb.lb.id}"
  name                = "${var.loadbalancer_name}-probe"
  protocol            = "Tcp"
  port                = "${var.request_port}"
}

resource "azurerm_lb_rule" "lb_rule" {
  resource_group_name            = "${var.resource_group_name}"
  loadbalancer_id                = "${azurerm_lb.lb.id}"
  name                           = "${var.loadbalancer_name}-LBRule"
  protocol                       = "Udp"
  frontend_port                  = 53
  backend_port                   = 53
  frontend_ip_configuration_name = "${var.loadbalancer_name}-IP"
  backend_address_pool_id        = "${azurerm_lb_backend_address_pool.bekpool.id}"
  probe_id                       = "${azurerm_lb_probe.lb_probe.id}"
}
