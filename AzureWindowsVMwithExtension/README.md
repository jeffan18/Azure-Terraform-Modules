```
module "jumpbox" {
	source = "git::ssh://git@code.siemens.com/mindsphere-azure/infrastructure_az/terraform_modules/jumpbox.git"
	
	// Parameters
	resource_group_name = "${module.resource_group.name}"
	location = "${var.location}"
	subnet_id = "${module.network.management_subnet_id}"
	storage_account_name = "${module.storageact.storageAccountName}"
	storage_container_name = "${module.storageContainer.jumpbox_container_name}"
	storage_account_name_primary_blob_endpoint = "${module.storageact.storageAccountPrimaryBlobEndPoint}"	
	
	tags = "${local.tags}"	
}
```