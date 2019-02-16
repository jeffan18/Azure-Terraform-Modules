```
//Logic Application
module "logicapp" {
  source = "git::ssh://git@Sourcecode_url"
  logic_app_name = "${var.logic_app_name}"
  resource_group_name = "${module.resource_group.name}"
  location = "${module.resource_group.location}"
  tags = "${var.tags}"
}

```