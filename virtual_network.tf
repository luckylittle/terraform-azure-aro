# Create a virtual network within the resource group
resource "azurerm_virtual_network" "virtual-network" {
  name                = "virtual-network-${local.environment}"
  resource_group_name = azurerm_resource_group.openshift-cluster.name
  location            = azurerm_resource_group.openshift-cluster.location
  address_space       = ["10.0.0.0/22"]
  tags                = local.common_tags
}
