# Deploy ARO using ARM template

resource "azurerm_template_deployment" "aro-cluster" {
  name                = "openshift-cluster-${local.environment}"
  resource_group_name = azurerm_resource_group.openshift-cluster.name

  template_body = file("${path.module}/ARM-openShiftClusters.json")

  parameters = {
    "clusterResourceGroupName" = azurerm_resource_group.openshift-cluster.name
    "clusterName"              = "openshift-cluster-${local.environment}"
    "location"                 = var.location
    "workerSubnetId"           = azurerm_subnet.worker-subnet.id
    "masterSubnetId"           = azurerm_subnet.master-subnet.id
    "tags"                     = jsonencode(local.common_tags)
    "pullSecret"               = file("${path.module}/pull-secret.txt")
  }

  deployment_mode = "Incremental"

  depends_on = [
    azurerm_subnet.master-subnet,
    azurerm_subnet.worker-subnet
  ]
}
