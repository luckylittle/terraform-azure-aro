# Create a resource group

resource "azurerm_resource_group" "openshift-cluster" {
  name     = "openshift-cluster-${local.environment}"
  location = var.location
  tags     = local.common_tags
}
