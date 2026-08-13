module "resource_group" {
  source = "../../modules/azurerm_resource_group"
  rgs    = var.rgs
}
module "virtual_network" {
  depends_on = [module.resource_group]
  source     = "../../modules/azurerm_virtual_network"
  vnets      = var.vnets
}
module "subnet" {
  depends_on = [module.virtual_network]
  source     = "../../modules/azurerm_subnet"
  subnets    = var.subnets
}
module "public_ip" {
  depends_on = [module.resource_group]
  source     = "../../modules/azurerm_public_ip"
  pips       = var.pips
}
module "network_security_group" {
  depends_on     = [module.subnet]
  source         = "../../modules/azurerm_network_security_group"
  nsgs           = var.nsgs
  security_rules = var.security_rules
}
module "linux_virtual_machine" {
  depends_on = [module.subnet, module.public_ip]
  source     = "../../modules/azurerm_virtual_machine"
  vms        = var.vms
}


