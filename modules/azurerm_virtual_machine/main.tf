resource "azurerm_network_interface" "this" {
for_each = var.vms
  name                =each.value.nic_name
  location            =each.value.location
  resource_group_name =each.value.rg_name

  ip_configuration {
    name                          = each.value.ip_configname
    subnet_id                     = data.azurerm_subnet.this[each.key].id
    public_ip_address_id = data.azurerm_public_ip.this[each.key].id
    private_ip_address_allocation = each.value.private_ip_allocation
  }
}

resource "azurerm_linux_virtual_machine" "this" {
for_each = var.vms
  name                = each.value.vm_name
  resource_group_name = each.value.rg_name
  location            = each.value.location
  size                =each.value.vm_size
  admin_username      = each.value.admin_username
  admin_password = each.value.admin_password
  disable_password_authentication =each.value.disable_password
  network_interface_ids = [azurerm_network_interface.this[each.key].id]
  

  
  os_disk {
    caching              = each.value.caching
    storage_account_type = each.value.storage_account_type
  }

  source_image_reference {
    publisher = each.value.publisher
    offer     = each.value.offer
    sku       = each.value.sku
    version   = each.value.version
  }
}