module "functionapp" {
	source = "git::ssh://git@code.siemens.com/mindsphere-azure/infrastructure_az/terraform_modules/function-app.git"
	
	// Parameters
	function_app_plan_name  = "${var.function_plan_name}"
	function_app_name       = "${var.function_app_name}"
	storage_conn_string     = "${data.terraform_remote_state.pl_acrh_state.storageaccount_primary_connection_string}"
	resource_group_name     = "${data.terraform_remote_state.pl_acrh_state.resource_group_name}"
	location                = "${var.location}"
	app_settings            =[
	{
      name="PRODUCTLINE_NAME"
      value="strt"
    }
    ]
}
