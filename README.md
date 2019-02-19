# Terraform
Download Terraform
https://www.terraform.io/downloads.html

Terraform installation on CentOs:

SSH into your cloud server

sudo yum install -y zip unzip (if these are not installed)

wget https://releases.hashicorp.com/terraform/0.9.8/terraform_0.11.7_linux_amd64.zip

unzip terraform_0.11.7_linux_amd64.zip

sudo mv terraform /usr/local/bin/

Confirm terraform binary is accessible: terraform --version

Run following Command:

* terraform init : The terraform init command is used to initialize a working directory containing Terraform configuration files. This is the first command that should be run after writing a new Terraform configuration

* terraform plan : The terraform plan command is used to create an execution plan.

* terrafrom apply : By default, apply scans the current directory for the configuration and applies the changes appropriately.

* terraform destroy : Infrastructure managed by Terraform will be destroyed. This will ask for confirmation before destroying.

VM creation:
https://docs.microsoft.com/en-us/azure/virtual-machines/linux/terraform-create-complete-vm

Terraform Azure Document: https://www.terraform.io/docs/providers/azurerm/
