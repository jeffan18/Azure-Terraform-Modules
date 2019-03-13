#Module for AKS
// aks cluster
 module "akscluster" {
     source = "git::ssh://git@code-repository"

     // Parameters
     aks_name            = "${module.resource_group.name}-aks"
     dns_prefix          = "dns_prefix"
     resource_group_name = "${module.resource_group.name}"
     location            = "${var.location}"
     client_id           = "${var.k8s_client_id}"
     client_secret       = "${var.k8s_client_secret}"
     subscription_id     = "${var.subscription_id}"
     agentVMSize         = "${var.agentVMSize}"
     kubernetesVersion   = "1.11.5"
 }
