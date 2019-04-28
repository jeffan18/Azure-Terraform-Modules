data "template_file" "hbase-cluster" {
  template = "${file("${path.module}/hbase.json")}"
}

resource "azurerm_template_deployment" "hbase-clusetr" {

  name        = "${var.clusterName}"
  resource_group_name = "${var.resource_group_name}"

  template_body = <<DEPLOY
  ${data.template_file.hbase-cluster.template}
  DEPLOY

  parameters {
    clusterName="${var.clusterName}"
	  clusterLoginUserName="${var.clusterLoginUserName}"  
    clusterLoginPassword="${var.clusterLoginPassword}"
    sshUserName="${var.sshUserName}"
    sshPassword="${var.sshPassword}"
    vnetId="${var.vnetId}"
    subnetId="${var.subnetId}"
    headnodeInstanceCount="${var.headnodeInstanceCount}"
    headnodevmSize="${var.headnodevmSize}"
    workernodeInstanceCount="${var.workernodeInstanceCount}"
    workernodevmSize="${var.workernodevmSize}"
    zookeepernodeInstanceCount="${var.zookeepernodeInstanceCount}"
    zookeepernodevmSize="${var.zookeepernodevmSize}"
    accountName                       = "${var.account_name}"
    environment                       = "${var.environment}"
    team                              = "${var.team}"

  }
  deployment_mode = "Incremental"
}
