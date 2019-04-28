```
module "storageTable" {
    source = "git::ssh://GitURL"

    // Parameters
	storage_table_name  = "${var.storage_table_name}"
    resource_group = "${module.resource_group.name}"
    storage_act_name 	= "${module.storageact.storageAccountName}"    
}
```