resource "azurerm_subnet" "default" {
  name                 = "${var.app_name}_subnet"
  resource_group_name  = "${var.rg_name}"
  virtual_network_name = "${azure_virtual_network.default.name}"
  address_prefixes     = ["10.1.4.0/25"]
}