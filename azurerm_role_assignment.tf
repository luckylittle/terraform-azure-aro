# Assigns a given Principal (User or Group) to a given Role.

resource "azurerm_role_assignment" "virtual-network-assignment" {
  count                = length(var.roles)
  scope                = azurerm_virtual_network.virtual-network.id
  role_definition_name = var.roles[count.index].role
  principal_id         = var.client_object_id
}

resource "azurerm_role_assignment" "resource-provider-assignment" {
  count                = length(var.roles)
  scope                = azurerm_virtual_network.virtual-network.id
  role_definition_name = var.roles[count.index].role
  principal_id         = var.rp_object_id
}
