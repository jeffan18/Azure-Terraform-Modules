```
//Hbase 
module "hbase" {
  source = "git::ssh://git@hbase.git"
  clusterName=""
  clusterLoginUserName=""
  clusterLoginPassword=""
  sshUserName=""
  sshPassword=""
  vnetId=""
  subnetId =""
  resource_group_name=""
  headnodeInstanceCount=""
  headnodevmSize=""
  workernodeInstanceCount=""
  workernodevmSize=""
  zookeepernodeInstanceCount=""
  zookeepernodevmSize=""
  team = "${var.team}"
  environment = "${var.environment}"
  account_name  = "${var.account_name}"
}
```
