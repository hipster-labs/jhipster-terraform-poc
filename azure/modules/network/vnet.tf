resource "azure_virtual_network" "default" {
  name          = "${var.app_name}_vnet"
  address_space = ["10.1.2.0/24"]
  location      = "${var.location}"
}
