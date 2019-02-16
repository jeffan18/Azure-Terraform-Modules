```
module "loganalytics" {
  source = "git::ssh://git@sourcecode_url"
    // Parameters
    resource_group_name = "${module.resource_group.name}"
    log_analytics_workspace = "${var.log_analytics_workspace}"
    pricing_sb = "${var.pricing_log}"
    location = "${var.location}"
}
```