data "azurerm_subnet" "this" {
for_each =var.vms
  name                 = each.value.subnet_name
  virtual_network_name = each.value.vnet_name
  resource_group_name  = each.value.rg_name
}

data "azurerm_public_ip" "this" {
for_each = var.vms
  name                = each.value.pip_name
  resource_group_name = each.value.rg_name
}
data "azurerm_key_vault" "this" {
  for_each = var.vms
  name                = each.value.kvname
  resource_group_name = each.value.resource_group_name
}

data "azurerm_key_vault_secret" "this" {
  for_each = var.vms
  name         = each.value.secret_name
  key_vault_id = data.azurerm_key_vault.this[each.key].id
}
