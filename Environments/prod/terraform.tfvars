rgs = {
  rg1 = {
    name     = "prod-pk1"
    location = "South India"
  }


}
vnets = {
  vnet1 = {
    name                = "prod-vnet"
    location            = "South India"
    resource_group_name = "prod-pk1"
    address_space       = ["10.0.0.0/16"]

  }
}
pips = {
  pip1 = {
    name                = "frontend-pip"
    resource_group_name = "prod-pk1"
    location            = "South India"
    allocation_method   = "Static"
  }
  pip2 = {
    name                = "backend-pip"
    resource_group_name = "prod-pk1"
    location            = "South India"
    allocation_method   = "Static"
  }
}

subnets = {
  subnet1 = {
    name                 = "frontend-subnet"
    virtual_network_name = "prod-vnet"
    resource_group_name  = "prod-pk1"
    address_prefixes     = ["10.0.1.0/24"]
  }
  subnet2 = {
    name                 = "backend-subnet"
    virtual_network_name = "prod-vnet"
    resource_group_name  = "prod-pk1"
    address_prefixes     = ["10.0.2.0/24"]
  }
}

nsgs = {
  nsg1 = {
    nsg_name    = "frontend-nsg"
    location    = "South India"
    rg_name     = "prod-pk1"
    subnet_name = "frontend-subnet"
    vnet_name   = "prod-vnet"

  }
  nsg2 = {
    nsg_name    = "backend-nsg"
    location    = "South India"
    rg_name     = "prod-pk1"
    subnet_name = "backend-subnet"
    vnet_name   = "prod-vnet"

  }
}
security_rules = {
  security_rule1 = {
    name                       = "SSH"
    priority                   = "100"
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"

  }
  security_rule2 = {
    name                       = "HTTP"
    priority                   = "101"
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"

  }
}
vms = {
  vm1 = {
    nic_name              = "frontend-nic"
    location              = "South India"
    rg_name               = "prod-pk1"
    ip_configname         = "internal"
    private_ip_allocation = "Dynamic"
    subnet_name           = "frontend-subnet"
    vnet_name             = "prod-vnet"
    pip_name              = "frontend-pip"
    vm_name               = "frontend-vm"
    vm_size               = "Standard_D4as_v5"
    admin_username        = "azureuser"
    admin_password        = "Ericsson@2026"
    disable_password      = false
    caching               = "ReadWrite"
    storage_account_type  = "Standard_LRS"
    publisher             = "Canonical"
    offer                 = "0001-com-ubuntu-server-jammy"
    sku                   = "22_04-lts"
    version               = "latest"
  }
  vm2 = {
    nic_name              = "backend-nic"
    location              = "South India"
    rg_name               = "prod-pk1"
    ip_configname         = "internal"
    private_ip_allocation = "Dynamic"
    subnet_name           = "backend-subnet"
    vnet_name             = "prod-vnet"
    pip_name              = "backend-pip"
    vm_name               = "backend-vm"
    vm_size               = "Standard_D4as_v5"
    admin_username        = "azureuser"
    admin_password        = "Ericsson@2026"
    disable_password      = false
    caching               = "ReadWrite"
    storage_account_type  = "Standard_LRS"
    publisher             = "Canonical"
    offer                 = "0001-com-ubuntu-server-jammy"
    sku                   = "22_04-lts"
    version               = "latest"
  }
}

