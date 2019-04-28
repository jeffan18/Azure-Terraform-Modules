<<<<<<< HEAD
```
module "network" {
  source = "git::ssh://GITURL"

  // Parameters
  resource_group = "${module.resource_group.name}"
  location = "${module.resource_group.location}"
  vnet_address_prefix = "${var.vnet_address_prefix}"
  remote_vnet_ids = "${var.remote_vnet_ids}"
  tags = "${var.tags}"
}
=======
```
module "network" {
  source = "git::ssh://GITURL"

  // Parameters
  resource_group = "${module.resource_group.name}"
  location = "${module.resource_group.location}"
  vnet_address_prefix = "${var.vnet_address_prefix}"
  remote_vnet_ids = "${var.remote_vnet_ids}"
  tags = "${var.tags}"
}
>>>>>>> 56afe5eb5a80229ccec9da2ca0d126020b4f0dd0
```