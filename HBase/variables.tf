variable "clusterName" {}

variable "clusterLoginUserName" {}

variable "clusterLoginPassword" {}

variable "sshUserName" { }

variable "sshPassword" {}
variable "vnetId" {}

variable "subnetId" {}

variable "resource_group_name" {}

variable "headnodeInstanceCount" {
    default=2
}
variable "headnodevmSize" {
    default="Standard_D3_v2"
}
variable "workernodeInstanceCount" {
    default=2
}
variable "workernodevmSize" {
    default="Standard_D3_v2"
}

variable "zookeepernodeInstanceCount" {
    default=3
}
variable "zookeepernodevmSize" {
    default="Standard_A3"
}

variable "team" {
  type = "string"
}

variable "account_name" {
  type = "string"
}
variable "environment" {
    type = "string"
}
