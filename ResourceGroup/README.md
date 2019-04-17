```
    module "resource_group" {
  source = "git::ssh://GITURL"

  // Parameters
  name = "${var.name}"
  location = "${var.location}"

  tags = "${var.tags}"
}
```