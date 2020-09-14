data "azurerm_subnet" "default" {
  name                 = "${var.app_name}_subnet"
  virtual_network_name = "${var.app_name}_vnet"
  resource_group_name  = "${var.rg_name}"
}