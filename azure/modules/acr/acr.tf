resource "azurerm_container_registry" "acr" {
  name                     = "${var.container_name}"
  resource_group_name      = "${var.rg_name}"
  location                 = "${var.location}"
  sku                      = "Standard"
  admin_enabled            = false
  georeplication_locations = ["North Europe", "West Europe"]
  tags = {
    Environment = "${var.environment}"
    Owner = "${var.owner}"
  }
}