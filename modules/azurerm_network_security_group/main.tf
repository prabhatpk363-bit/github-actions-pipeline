data "azurerm_subnet" "this" {
for_each =var.nsgs
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.rg_name
}

resource "azurerm_network_security_group" "this" {
for_each = var.nsgs
  name                = each.value.nsg_name
  location            = each.value.location
  resource_group_name = each.value.rg_name

dynamic "security_rule" {
    for_each =var.security_rules
    iterator = sr
    content {
    name                       = sr.value.name
    priority                   = sr.value.priority
    direction                  = sr.value.direction
    access                     = sr.value.access
    protocol                   = sr.value.protocol
    source_port_range          = sr.value.source_port_range
    destination_port_range     = sr.value.destination_port_range
    source_address_prefix      = sr.value.source_address_prefix
    destination_address_prefix = sr.value.destination_address_prefix
    }
  }
}
resource "azurerm_subnet_network_security_group_association" "this" {
  for_each = var.nsgs
  subnet_id                 = data.azurerm_subnet.this[each.key].id
  network_security_group_id = azurerm_network_security_group.this[each.key].id
}

