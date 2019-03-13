data "template_file" "aks_init" {
  template = "${file("${path.module}/aks.json")}"
}

resource "azurerm_log_analytics_workspace" "aksanalytics" {
  name                = "${var.aks_name}-log-analytics-workspace"
  location            = "${var.location}"
  resource_group_name = "${var.resource_group_name}"
  sku                 = "Standard"
  retention_in_days   = 30
}

resource "azurerm_template_deployment" "aks_cluster" {
  name ="${var.aks_name}" 
  resource_group_name = "${var.resource_group_name}"

 template_body = <<DEPLOY
  ${data.template_file.aks_init.template}
  DEPLOY

  parameters {
    resourceName                 = "${var.aks_name}"
    location                     = "${var.location}"
    dnsPrefix                    = "${var.dns_prefix}"
    agentVMSize                  = "${var.agentVMSize}"
    servicePrincipalClientId     = "${var.client_id}"
    servicePrincipalClientSecret = "${var.client_secret}"
    kubernetesVersion            = "${var.kubernetesVersion}"
    workspaceName                = "${azurerm_log_analytics_workspace.aksanalytics.name}"
    omsWorkspaceId               = "${azurerm_log_analytics_workspace.aksanalytics.id}"
    workspaceRegion              = "${var.location}"
    networkPlugin                = "azure"
    vnetSubnetID                 = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/virtualNetworks/${var.resource_group_name}-vnet-18/subnets/${var.resource_group_name}-aks-private-subnet"
    serviceCidr                  = "10.0.0.0/16"
    dnsServiceIP                 = "10.0.0.10"
    dockerBridgeCidr             = "172.17.0.1/16"
    accountName             = "${var.account_name}"
    environment             = "${var.environment}"
    team                    = "${var.team}"


  }

  deployment_mode = "Incremental"
}
