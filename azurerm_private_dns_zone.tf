# Create a private DNS zone within the resource group

resource "azurerm_private_dns_zone" "private-dns-zone" {
  name                = local.domain_name
  resource_group_name = azurerm_resource_group.openshift-cluster.name
  tags                = local.common_tags
}
