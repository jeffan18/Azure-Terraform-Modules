```
module "automationact" {
	source = "git::ssh://git@code.siemens.com/mindsphere-azure/infrastructure_az/terraform_modules/automationAccount.git"
	
	// Parameters
	automation_acc_name = "${var.automation_acc_name}"
	resource_group_name = "${var.resource_group.name}"
	location = "${var.location}"
	sku_name = "${var.sku_name}"
	tags = "${local.tags}"	
}
```

