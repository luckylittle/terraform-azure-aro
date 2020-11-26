# Deploy ARO using ARM template

resource "azurerm_template_deployment" "aro-cluster" {
  name                = "openshift-cluster-${local.environment}"
  resource_group_name = azurerm_resource_group.openshift-cluster.name

  template_body = file("${path.module}/ARM-openShiftClusters.json")

  parameters = {
    "clientId"                 = var.clientId
    "clientSecret"             = var.clientSecret
    "clusterName"              = "openshift-cluster-${local.environment}"
    "clusterResourceGroupName" = azurerm_resource_group.openshift-cluster.name
    "domain"                   = local.domain_name
    "location"                 = var.location
    "masterSubnetId"           = azurerm_subnet.master-subnet.id
    "pullSecret"               = file("${path.module}/pull-secret.txt")
    "tags"                     = jsonencode(local.common_tags)
    "workerSubnetId"           = azurerm_subnet.worker-subnet.id
  }

  deployment_mode = "Incremental"

  depends_on = [
    azurerm_subnet.master-subnet,
    azurerm_subnet.worker-subnet
  ]
}
